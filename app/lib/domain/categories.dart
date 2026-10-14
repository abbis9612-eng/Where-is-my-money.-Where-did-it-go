/// Default categories for an Iraqi household. Keys are stable identifiers
/// stored in the database; names are what people see.
library;

enum CategoryKind { expense, income }

/// Needs / wants / savings, used by the monthly report.
enum CategoryGroup { needs, wants, savings }

class CategorySeed {
  const CategorySeed({
    required this.key,
    required this.name,
    required this.kind,
    required this.group,
    this.keywords = const [],
    this.fixed = false,
  });

  final String key;
  final String name;
  final CategoryKind kind;
  final CategoryGroup group;

  /// Words the sentence and voice parser maps to this category.
  final List<String> keywords;

  /// Fixed monthly bills are posted automatically and do not count against
  /// the weekly allowance.
  final bool fixed;
}

const kDefaultCategories = <CategorySeed>[
  CategorySeed(key: 'bread_veg', name: 'خبز وخضرة', kind: CategoryKind.expense, group: CategoryGroup.needs,
      keywords: ['صمون', 'خبز', 'خضرة', 'خضار', 'فواكه', 'فاكهة', 'طماطة', 'بطاطا', 'بصل']),
  CategorySeed(key: 'groceries', name: 'بقالة', kind: CategoryKind.expense, group: CategoryGroup.needs,
      keywords: ['بقالة', 'ماركت', 'سوق', 'مول', 'رز', 'دهن', 'لحم', 'دجاج', 'بيض', 'جبن', 'سكر', 'شاي', 'طحين']),
  CategorySeed(key: 'generator', name: 'مولدة', kind: CategoryKind.expense, group: CategoryGroup.needs,
      keywords: ['مولدة', 'امبير', 'أمبير', 'كهرباء'], fixed: true),
  CategorySeed(key: 'fuel', name: 'بنزين', kind: CategoryKind.expense, group: CategoryGroup.needs,
      keywords: ['بنزين', 'كاز', 'وقود', 'تعبئة', 'تانكي']),
  CategorySeed(key: 'eating_out', name: 'أكل برّه', kind: CategoryKind.expense, group: CategoryGroup.wants,
      keywords: ['مطعم', 'عشا', 'عشاء', 'غدا', 'غداء', 'برگر', 'بركر', 'بيتزا', 'شاورما', 'كص', 'كباب', 'باجة', 'فلافل', 'لفة']),
  CategorySeed(key: 'kid', name: 'الطفل', kind: CategoryKind.expense, group: CategoryGroup.needs,
      keywords: ['حفاظات', 'حليب', 'لعبة', 'ألعاب', 'العاب', 'روضة']),
  CategorySeed(key: 'health', name: 'علاج', kind: CategoryKind.expense, group: CategoryGroup.needs,
      keywords: ['دوا', 'دواء', 'صيدلية', 'طبيب', 'دكتور', 'تحليل', 'مستشفى', 'عيادة', 'أشعة', 'اشعة']),
  CategorySeed(key: 'transport', name: 'مواصلات', kind: CategoryKind.expense, group: CategoryGroup.needs,
      keywords: ['تكسي', 'كيا', 'نقل', 'كروة', 'باص']),
  CategorySeed(key: 'phone_net', name: 'رصيد ونت', kind: CategoryKind.expense, group: CategoryGroup.needs,
      keywords: ['رصيد', 'كارت', 'انترنت', 'إنترنت', 'نت'], fixed: true),
  CategorySeed(key: 'home', name: 'بيت', kind: CategoryKind.expense, group: CategoryGroup.needs,
      keywords: ['منظفات', 'غاز', 'تصليح', 'أدوات', 'ادوات', 'ماي', 'ماء']),
  CategorySeed(key: 'clothes', name: 'ملابس', kind: CategoryKind.expense, group: CategoryGroup.wants,
      keywords: ['ملابس', 'حذاء', 'قندرة', 'نعال', 'قميص', 'بنطرون', 'دشداشة']),
  CategorySeed(key: 'occasions', name: 'مناسبات', kind: CategoryKind.expense, group: CategoryGroup.wants,
      keywords: ['هدية', 'عرس', 'مناسبة', 'عيدية', 'فاتحة', 'تعزية']),
  CategorySeed(key: 'sadaqa', name: 'صدقة وزكاة', kind: CategoryKind.expense, group: CategoryGroup.needs,
      keywords: ['صدقة', 'صدقات', 'تبرع', 'تبرعت', 'زكاة', 'زكاه', 'فطرة', 'فطره', 'خيرات']),
  CategorySeed(key: 'small', name: 'أشياء صغيرة', kind: CategoryKind.expense, group: CategoryGroup.wants),
  CategorySeed(key: 'other', name: 'غيرها', kind: CategoryKind.expense, group: CategoryGroup.wants),
  CategorySeed(key: 'salary', name: 'راتب', kind: CategoryKind.income, group: CategoryGroup.needs,
      keywords: ['راتب', 'معاش']),
  CategorySeed(key: 'other_income', name: 'دخل ثاني', kind: CategoryKind.income, group: CategoryGroup.needs),
];

CategorySeed categoryByKey(String key) =>
    kDefaultCategories.firstWhere((c) => c.key == key, orElse: () => kDefaultCategories.firstWhere((c) => c.key == 'other'));
