-- Joining a family with the invite code shown in the app (e.g. WF-7Q2K).
-- Links the signed-in user to an existing member row by id when the inviter
-- pre-created it, otherwise adds a new adult member.
create or replace function public.join_household(code text, member_name text)
returns table (household_id text, member_id text)
language plpgsql security definer set search_path = public as $$
declare
  h public.households;
  mid text;
begin
  if auth.uid() is null then
    raise exception 'sign in first';
  end if;
  select * into h from public.households where invite_code = upper(trim(code)) and deleted_at is null;
  if h.id is null then
    raise exception 'invite code not found';
  end if;
  select m.id into mid from public.members m
    where m.household_id = h.id and m.user_id = auth.uid()::text and m.deleted_at is null;
  if mid is null then
    mid := gen_random_uuid()::text;
    insert into public.members (id, household_id, created_at, updated_at, display_name, role, letter, color_index, user_id, free_allowance, sort_order)
    values (mid, h.id, now(), now(), member_name, 'member', left(member_name, 1), 1, auth.uid()::text, 0, 1);
  end if;
  return query select h.id, mid;
end $$;

revoke all on function public.join_household(text, text) from public;
grant execute on function public.join_household(text, text) to authenticated;

create unique index if not exists households_invite on public.households (invite_code) where deleted_at is null;
