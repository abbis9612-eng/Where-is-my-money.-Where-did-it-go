/// Hand-drawn icon set for «وين فلوسي» (design E). Generated from
/// design/G-three-directions/E_Icons.dc.html: 24 grid, 1.7 round stroke,
/// 12% tint of the ink colour and one gold detail per glyph.
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum WfGlyph {
  today, envelopes, whereWent, family, add, mic, qiInbox, vault, bread, bag, fuel, baby, grill, health, generator, phone, sadaqa, home, transport, clothes, occasions, small, other, salary;
}

const _svg = <WfGlyph, String>{
  WfGlyph.today: '<rect x="2.5" y="6" width="15" height="9" rx="1.8" transform="rotate(-9 10 10.5)" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"></rect><rect x="6.5" y="9.5" width="15" height="9" rx="1.8" fill="var(--bg)"></rect><rect x="6.5" y="9.5" width="15" height="9" rx="1.8" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"></rect><circle cx="11" cy="14" r="2.1" fill="none" stroke="#D8AE55" stroke-width="1.6"></circle><path d="M15.5 12.5h3.5M15.5 15.5h2.2" stroke="#D8AE55" stroke-width="1.6" stroke-linecap="round"></path>',
  WfGlyph.envelopes: '<rect x="7" y="2.8" width="10" height="9" rx="1.3" fill="#D8AE55"></rect><path d="M9.5 5.8h5" stroke="var(--bg)" stroke-width="1.3" stroke-linecap="round"></path><rect x="3" y="9" width="18" height="12" rx="2.2" fill="var(--bg)"></rect><rect x="3" y="9" width="18" height="12" rx="2.2" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"></rect><path d="M3.6 10.4 12 16l8.4-5.6" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linejoin="round"></path>',
  WfGlyph.whereWent: '<rect x="3" y="12" width="5" height="9" rx="1.2" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7" stroke-linejoin="round"></rect><rect x="9.5" y="4.5" width="5" height="16.5" rx="1.2" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7" stroke-linejoin="round"></rect><rect x="16" y="9" width="5" height="12" rx="1.2" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7" stroke-linejoin="round"></rect><path d="M3 16.3h5M9.5 12.5h5M16 14.8h5" stroke="#D8AE55" stroke-width="2.4"></path>',
  WfGlyph.family: '<path d="M4.5 21V11.5a7.5 7.5 0 0 1 15 0V21z" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7" stroke-linejoin="round"></path><circle cx="9.2" cy="11.8" r="1.8" fill="currentColor"></circle><circle cx="14.8" cy="11.8" r="1.8" fill="currentColor"></circle><path d="M6.9 18.8c0-2 1-3.2 2.3-3.2s2.3 1.2 2.3 3.2M12.5 18.8c0-2 1-3.2 2.3-3.2s2.3 1.2 2.3 3.2" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"></path><circle cx="12" cy="17.3" r="1.4" fill="#D8AE55"></circle>',
  WfGlyph.add: '<rect x="2.5" y="6.5" width="15" height="10" rx="1.8" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"></rect><circle cx="8" cy="11.5" r="2" fill="none" stroke="currentColor" stroke-width="1.5"></circle><circle cx="17.5" cy="16.5" r="4.8" fill="#D8AE55"></circle><path d="M17.5 14.2v4.6M15.2 16.5h4.6" stroke="#2B1D00" stroke-width="1.8" stroke-linecap="round"></path>',
  WfGlyph.mic: '<rect x="8.5" y="2.5" width="7" height="12" rx="3.5" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"></rect><path d="M10.6 6.5h2.8M10.6 9.5h2.8" stroke="#D8AE55" stroke-width="1.6" stroke-linecap="round"></path><path d="M5 11a7 7 0 0 0 14 0M12 18v3M9 21h6" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"></path>',
  WfGlyph.qiInbox: '<rect x="2.5" y="5" width="16" height="11" rx="2" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"></rect><rect x="5" y="8" width="4.2" height="3.2" rx=".8" fill="#D8AE55"></rect><path d="M5 13.3h6" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"></path><path d="M14.5 12.5h7v5.5h-3.2l-2.3 2.4V18h-1.5z" fill="var(--bg)" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"></path><circle cx="16.8" cy="15.2" r=".9" fill="#D8AE55"></circle><circle cx="19.2" cy="15.2" r=".9" fill="#D8AE55"></circle>',
  WfGlyph.vault: '<circle cx="12" cy="12" r="9" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"></circle><path d="M12 3v2.4M12 18.6V21M3 12h2.4M18.6 12H21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"></path><circle cx="12" cy="12" r="4.2" fill="none" stroke="#D8AE55" stroke-width="1.8"></circle><path d="M12 12l2.8-2.8" stroke="#D8AE55" stroke-width="1.8" stroke-linecap="round"></path>',
  WfGlyph.bread: '<path d="M2.5 12.8C6 7 18 5.4 21.5 9.8 18 15.8 6 17.4 2.5 12.8z" fill="#D8AE55" fill-opacity=".38" stroke="currentColor" stroke-width="1.7" stroke-linejoin="round"></path><path d="M8 10.4l1.4 3.3M12 9.4l1.4 3.4M16 9.1l1.2 3" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"></path><path d="M16.5 20.5c1.6-2.8 4-3.4 5-3.4-.4 2.6-2.6 4-5 3.4z" fill="#1B675B"></path>',
  WfGlyph.bag: '<path d="M4.5 4h4.2c0 2.2 1.4 3.4 3.3 3.4s3.3-1.2 3.3-3.4h4.2l-1.1 16.8H5.6z" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7" stroke-linejoin="round"></path><circle cx="12" cy="14" r="2.6" fill="none" stroke="#D8AE55" stroke-width="1.6"></circle>',
  WfGlyph.fuel: '<rect x="3.5" y="3.5" width="10.5" height="17.5" rx="1.6" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"></rect><rect x="5.9" y="6" width="5.7" height="4.2" rx=".8" fill="#D8AE55"></rect><path d="M14 9h2.3a1.5 1.5 0 0 1 1.5 1.5v6.3a1.6 1.6 0 0 0 3.2 0V8.4l-2.6-2.6M3 21h11.5" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"></path>',
  WfGlyph.baby: '<path d="M10.5 7V5.2a1.5 1.5 0 0 1 3 0V7" fill="none" stroke="currentColor" stroke-width="1.7"></path><path d="M8.5 7h7v2.3l1.2 1.6v9a2 2 0 0 1-2 2H9.3a2 2 0 0 1-2-2v-9l1.2-1.6z" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7" stroke-linejoin="round"></path><path d="M7.9 14.5h8.2v5a1.6 1.6 0 0 1-1.6 1.6H9.5a1.6 1.6 0 0 1-1.6-1.6z" fill="#D8AE55" fill-opacity=".9"></path><path d="M14.5 12.2h1.6M14.5 15.2h1.6" stroke="currentColor" stroke-width="1.3" stroke-linecap="round"></path>',
  WfGlyph.grill: '<path d="M3 21 21 3" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"></path><rect x="5.6" y="13.6" width="5" height="5" rx="1.5" transform="rotate(45 8.1 16.1)" fill="currentColor" fill-opacity=".2" stroke="currentColor" stroke-width="1.6"></rect><rect x="9.5" y="9.5" width="5" height="5" rx="1.5" transform="rotate(45 12 12)" fill="#D8AE55" stroke="currentColor" stroke-width="1.6"></rect><rect x="13.4" y="5.4" width="5" height="5" rx="1.5" transform="rotate(45 15.9 7.9)" fill="currentColor" fill-opacity=".2" stroke="currentColor" stroke-width="1.6"></rect>',
  WfGlyph.health: '<rect x="2.5" y="8.5" width="17" height="7" rx="3.5" transform="rotate(-35 11 12)" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"></rect><path d="M8.9 9.1l4.1 5.8" stroke="currentColor" stroke-width="1.6"></path><path d="M19 3.5v4.5M16.8 5.8h4.5" stroke="#D8AE55" stroke-width="1.8" stroke-linecap="round"></path>',
  WfGlyph.generator: '<rect x="2.5" y="8" width="13.5" height="11.5" rx="1.8" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"></rect><path d="M10.2 10.2l-2.4 3.5h3.2l-2.2 3.4" fill="none" stroke="#D8AE55" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"></path><path d="M16 11h2.4a2 2 0 0 0 2-2V3M17.5 3h5.5" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"></path><path d="M4 21.5h10.5" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"></path>',
  WfGlyph.phone: '<rect x="6" y="2.5" width="11" height="19" rx="2.4" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"></rect><path d="M9.8 18.5h3.4" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"></path><path d="M8.8 9.6a4.2 4.2 0 0 1 5.4 0M10.2 11.8a2 2 0 0 1 2.6 0" fill="none" stroke="#D8AE55" stroke-width="1.7" stroke-linecap="round"></path><circle cx="11.5" cy="13.8" r=".9" fill="#D8AE55"></circle>',
  WfGlyph.sadaqa: '<circle cx="13" cy="6.8" r="3.6" fill="#D8AE55"></circle><circle cx="13" cy="6.8" r="1.8" fill="none" stroke="#7A5A14" stroke-width="1"></circle><path d="M2.5 15h3.6l3.6 1.5h4.4a1.5 1.5 0 0 1 0 3H9.8" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"></path><path d="M14.1 18.3l5-2.4a1.6 1.6 0 0 1 1.7 2.7L14.6 22H6.1V15" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"></path>',
  WfGlyph.home: '<path d="M4 21V9.5L12 4l8 5.5V21z" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7" stroke-linejoin="round"></path><path d="M9.5 21v-5.5a2.5 2.5 0 0 1 5 0V21" fill="none" stroke="currentColor" stroke-width="1.7"></path><path d="M7 12h2.5M14.5 12H17" stroke="#D8AE55" stroke-width="1.8" stroke-linecap="round"></path>',
  WfGlyph.transport: '<rect x="2.5" y="6" width="19" height="11" rx="2.5" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"/><path d="M5 9.5h14" stroke="#D8AE55" stroke-width="2.4"/><circle cx="7" cy="18" r="2" fill="var(--bg)" stroke="currentColor" stroke-width="1.7"/><circle cx="17" cy="18" r="2" fill="var(--bg)" stroke="currentColor" stroke-width="1.7"/><path d="M12 6v6" stroke="currentColor" stroke-width="1.5"/>',
  WfGlyph.clothes: '<path d="M8.5 3.5 3 6.5l2 4.2 2.2-1V20.5h9.6V9.7l2.2 1 2-4.2-5.5-3c-.6 1.6-1.9 2.5-3.5 2.5s-2.9-.9-3.5-2.5z" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7" stroke-linejoin="round"/><circle cx="12" cy="11" r="1.1" fill="#D8AE55"/><circle cx="12" cy="15" r="1.1" fill="#D8AE55"/>',
  WfGlyph.occasions: '<rect x="3.5" y="9" width="17" height="11.5" rx="1.8" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"/><path d="M2.8 9h18.4" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"/><path d="M12 9v11.5" stroke="#D8AE55" stroke-width="2.4"/><path d="M12 8.6C10.5 5 7 4.6 7 6.6S10 8.6 12 8.6zM12 8.6c1.5-3.6 5-4 5-2S14 8.6 12 8.6z" fill="none" stroke="#D8AE55" stroke-width="1.6" stroke-linejoin="round"/>',
  WfGlyph.small: '<ellipse cx="12" cy="17" rx="7" ry="2.6" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"/><path d="M5 17v-3.3M19 17v-3.3" stroke="currentColor" stroke-width="1.7"/><ellipse cx="12" cy="13.7" rx="7" ry="2.6" fill="var(--bg)"/><ellipse cx="12" cy="13.7" rx="7" ry="2.6" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"/><ellipse cx="12" cy="9.5" rx="5" ry="2" fill="#D8AE55"/><path d="M7 9.5v-2.6M17 9.5V6.9" stroke="#D8AE55" stroke-width="1.6"/><ellipse cx="12" cy="6.9" rx="5" ry="2" fill="#E9C979"/>',
  WfGlyph.other: '<rect x="3.5" y="3.5" width="7" height="7" rx="2" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"/><rect x="13.5" y="3.5" width="7" height="7" rx="2" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"/><rect x="3.5" y="13.5" width="7" height="7" rx="2" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"/><circle cx="17" cy="17" r="3.6" fill="#D8AE55"/>',
  WfGlyph.salary: '<rect x="2.5" y="9" width="19" height="11" rx="2" fill="currentColor" fill-opacity=".12" stroke="currentColor" stroke-width="1.7"/><circle cx="12" cy="14.5" r="2.4" fill="none" stroke="currentColor" stroke-width="1.5"/><path d="M12 2.5v5M9.5 5.2 12 7.7l2.5-2.5" fill="none" stroke="#D8AE55" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"/>',
};

/// The glyph drawn for a spending category key.
WfGlyph glyphForCategory(String key) => switch (key) {
  'bread_veg' => WfGlyph.bread,
  'groceries' => WfGlyph.bag,
  'generator' => WfGlyph.generator,
  'fuel' => WfGlyph.fuel,
  'eating_out' => WfGlyph.grill,
  'kid' => WfGlyph.baby,
  'health' => WfGlyph.health,
  'transport' => WfGlyph.transport,
  'phone_net' => WfGlyph.phone,
  'home' => WfGlyph.home,
  'clothes' => WfGlyph.clothes,
  'occasions' => WfGlyph.occasions,
  'sadaqa' => WfGlyph.sadaqa,
  'small' => WfGlyph.small,
  'salary' || 'other_income' => WfGlyph.salary,
  _ => WfGlyph.other,
};

String _hex(Color c) => '#${(c.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

final _cache = <(WfGlyph, int), String>{};

/// One glyph. [color] is the ink, [background] fills the cut-outs between
/// overlapping shapes and must match whatever the glyph sits on.
class WfIcon extends StatelessWidget {
  const WfIcon(this.glyph, {super.key, this.size = 26, this.color, this.background});
  final WfGlyph glyph;
  final double size;
  final Color? color;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final ink = color ?? IconTheme.of(context).color ?? DefaultTextStyle.of(context).style.color ?? Colors.black;
    final bg = background ?? Theme.of(context).scaffoldBackgroundColor;
    final body = _cache.putIfAbsent(
      (glyph, bg.toARGB32()),
      () => '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">${_svg[glyph]!.replaceAll('var(--bg)', _hex(bg))}</svg>',
    );
    return ExcludeSemantics(
      child: SvgPicture.string(body, width: size, height: size, theme: SvgTheme(currentColor: ink)),
    );
  }
}

/// A glyph in a soft rounded tile, as used in lists.
class WfIconTile extends StatelessWidget {
  const WfIconTile(this.glyph, {super.key, this.size = 42, this.color, this.background, this.ink});
  final WfGlyph glyph;
  final double size;
  final Color? color;
  final Color? background;
  final Color? ink;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final bg = background ?? (dark ? const Color(0xFF15302A) : const Color(0xFFF2F6F4));
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(size / 3)),
      child: WfIcon(glyph, size: size * .64, color: ink ?? (dark ? const Color(0xFF9FD8C4) : const Color(0xFF0E3B32)), background: bg),
    );
  }
}

/// A category to pick: its glyph above its name, green when chosen.
class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.categoryKey, required this.label, required this.selected, required this.onTap, this.tag, this.width = 84});
  final String categoryKey;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? tag;
  final double width;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final green = dark ? const Color(0xFF9FD8C4) : const Color(0xFF0E3B32);
    final bg = selected ? (dark ? const Color(0xFF13302A) : const Color(0xFFEAF3EF)) : (dark ? const Color(0xFF0F2621) : Colors.white);
    final line = selected ? green : (dark ? const Color(0xFF1E3A33) : const Color(0xFFDCE3DF));
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: bg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: line, width: selected ? 2 : 1)),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: SizedBox(
            width: width,
            child: Stack(children: [
              Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  WfIcon(glyphForCategory(categoryKey), size: 28, color: green, background: bg),
                  const SizedBox(height: 3),
                  Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, height: 1.3, fontWeight: selected ? FontWeight.w600 : FontWeight.w400, color: selected ? green : null)),
                ]),
              ),
              if (tag != null)
                PositionedDirectional(
                  top: 4,
                  end: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(color: dark ? const Color(0x33E9C979) : const Color(0xFFFBF3E2), borderRadius: BorderRadius.circular(99)),
                    child: Text(tag!, style: TextStyle(fontSize: 9, height: 1.5, fontWeight: FontWeight.w600, color: dark ? const Color(0xFFE9C979) : const Color(0xFF7A5A14))),
                  ),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}
