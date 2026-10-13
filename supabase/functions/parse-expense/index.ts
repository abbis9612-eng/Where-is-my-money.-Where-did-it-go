// Parses an Iraqi-dialect expense sentence the on-device rules could not read.
// Only the sentence is sent (no names, balances or history). Requires a signed-in
// user (Supabase verifies the JWT before this runs).
// Secret: supabase secrets set ANTHROPIC_API_KEY=...
import Anthropic from "npm:@anthropic-ai/sdk";

const client = new Anthropic({ apiKey: Deno.env.get("ANTHROPIC_API_KEY") });

const CATEGORIES = [
  "bread_veg", "groceries", "generator", "fuel", "eating_out", "kid", "health",
  "transport", "phone_net", "home", "clothes", "occasions", "other",
];

const SCHEMA = {
  type: "object",
  properties: {
    items: {
      type: "array",
      items: {
        type: "object",
        properties: {
          label: { type: "string", description: "The thing bought, in the user's own words" },
          category: { type: "string", enum: CATEGORIES },
          amount: { type: "integer", description: "Whole dinars, or cents when currency is USD" },
          currency: { type: "string", enum: ["IQD", "USD"] },
        },
        required: ["label", "category", "amount", "currency"],
        additionalProperties: false,
      },
    },
  },
  required: ["items"],
  additionalProperties: false,
};

const SYSTEM = `You read short expense notes written or spoken by Iraqi families in Iraqi Arabic.
Return every purchase with its amount. Rules:
- Bare numbers under 250 mean thousands of dinars ("خبز 2" is 2000 IQD).
- "ورقة" is a 100 US dollar note; "دفتر" is 10,000 dollars. Dollar amounts are in cents.
- "ربع" is a quarter and "نص" a half of the following unit ("ربع مليون" = 250000).
- Use the closest category; use "other" when unsure. Never invent purchases that are not in the text.
- If the text contains no purchase, return an empty list.`;

Deno.serve(async (req) => {
  if (req.method !== "POST") return new Response("POST only", { status: 405 });
  let text = "";
  try {
    text = String((await req.json()).text ?? "").slice(0, 400);
  } catch {
    return Response.json({ error: "bad json" }, { status: 400 });
  }
  if (!text.trim()) return Response.json({ items: [] });

  const response = await client.beta.messages.create({
    model: "claude-opus-5-5",
    max_tokens: 2048,
    betas: ["server-side-fallback-2026-07-01"],
    fallbacks: "default",
    output_config: { effort: "low", format: { type: "json_schema", schema: SCHEMA } },
    system: SYSTEM,
    messages: [{ role: "user", content: text }],
  });

  if (response.stop_reason === "refusal") {
    return Response.json({ items: [], refused: true });
  }
  const block = response.content.find((b) => b.type === "text");
  if (!block || block.type !== "text") return Response.json({ items: [] });
  try {
    return Response.json(JSON.parse(block.text));
  } catch {
    return Response.json({ items: [] });
  }
});
