/// «لمسة بركة»: a small, verified set of Quran verses, hadith and du'a about
/// money, each shown where it fits (payday, Friday, a debt, going over the
/// week) instead of as a library nobody opens.
///
/// Every hadith carries its collection, number and grade. Only sahih and
/// hasan texts are included; the set was checked against dorar.net and
/// sunnah.com (see docs/07-barakah-sources.md). Change a text only with its
/// source.
library;

enum BarakahKind { quran, hadith, dua }

/// Where a text is shown.
enum BarakahPlace { daily, payday, friday, over, debt, family, kid, zakat, fitr, sadaqa }

class BarakahText {
  const BarakahText({
    required this.id,
    required this.kind,
    required this.text,
    required this.source,
    this.grade = '',
    this.note = '',
    required this.places,
  });

  final String id;
  final BarakahKind kind;

  /// The exact wording (a verse with its tashkeel, a hadith as narrated).
  final String text;

  /// "سبأ: 39", "رواه البخاري (1442) ومسلم (1010)".
  final String source;

  /// Empty for the Quran and for Bukhari/Muslim; otherwise who graded it.
  final String grade;

  /// One plain sentence on what it means for the family's money.
  final String note;
  final Set<BarakahPlace> places;

  String get citation => grade.isEmpty ? source : '$source، $grade';
}

/// The same text all day, a different one the next day.
BarakahText? barakahFor(BarakahPlace place, DateTime day, {List<BarakahText> from = kBarakahTexts}) {
  final list = from.where((t) => t.places.contains(place)).toList();
  if (list.isEmpty) return null;
  final n = DateTime.utc(day.year, day.month, day.day).millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;
  return list[n % list.length];
}

const kBarakahTexts = <BarakahText>[
  BarakahText(id: 'q_saba39', kind: BarakahKind.quran, text: '…وَمَا أَنفَقْتُم مِّن شَيْءٍ فَهُوَ يُخْلِفُهُ ۖ وَهُوَ خَيْرُ الرَّازِقِينَ', source: 'سبأ: 39', note: 'اللي تنفقونه بالخير ما يروح، الله يعوّضه.', places: {BarakahPlace.sadaqa, BarakahPlace.friday, BarakahPlace.daily}),
  BarakahText(id: 'q_baqara261', kind: BarakahKind.quran, text: 'مَثَلُ الَّذِينَ يُنفِقُونَ أَمْوَالَهُمْ فِي سَبِيلِ اللَّهِ كَمَثَلِ حَبَّةٍ أَنبَتَتْ سَبْعَ سَنَابِلَ فِي كُلِّ سُنبُلَةٍ مِّائَةُ حَبَّةٍ ۗ وَاللَّهُ يُضَاعِفُ لِمَن يَشَاءُ', source: 'البقرة: 261', places: {BarakahPlace.sadaqa}),
  BarakahText(id: 'q_baqara276', kind: BarakahKind.quran, text: 'يَمْحَقُ اللَّهُ الرِّبَا وَيُرْبِي الصَّدَقَاتِ', source: 'البقرة: 276', places: {BarakahPlace.zakat, BarakahPlace.sadaqa}),
  BarakahText(id: 'q_baqara282', kind: BarakahKind.quran, text: 'يَا أَيُّهَا الَّذِينَ آمَنُوا إِذَا تَدَايَنتُم بِدَيْنٍ إِلَىٰ أَجَلٍ مُّسَمًّى فَاكْتُبُوهُ', source: 'البقرة: 282', note: 'كتابة الدين أمر من القرآن، وهذا اللي تسوونه هنا.', places: {BarakahPlace.debt}),
  BarakahText(id: 'q_baqara280', kind: BarakahKind.quran, text: 'وَإِن كَانَ ذُو عُسْرَةٍ فَنَظِرَةٌ إِلَىٰ مَيْسَرَةٍ ۚ وَأَن تَصَدَّقُوا خَيْرٌ لَّكُمْ', source: 'البقرة: 280', places: {BarakahPlace.debt}),
  BarakahText(id: 'q_baqara271', kind: BarakahKind.quran, text: 'إِن تُبْدُوا الصَّدَقَاتِ فَنِعِمَّا هِيَ ۖ وَإِن تُخْفُوهَا وَتُؤْتُوهَا الْفُقَرَاءَ فَهُوَ خَيْرٌ لَّكُمْ', source: 'البقرة: 271', places: {BarakahPlace.sadaqa}),
  BarakahText(id: 'q_imran92', kind: BarakahKind.quran, text: 'لَن تَنَالُوا الْبِرَّ حَتَّىٰ تُنفِقُوا مِمَّا تُحِبُّونَ', source: 'آل عمران: 92', places: {BarakahPlace.friday, BarakahPlace.sadaqa}),
  BarakahText(id: 'q_talaq2', kind: BarakahKind.quran, text: '…وَمَن يَتَّقِ اللَّهَ يَجْعَل لَّهُ مَخْرَجًا ۝ وَيَرْزُقْهُ مِنْ حَيْثُ لَا يَحْتَسِبُ', source: 'الطلاق: 2–3', places: {BarakahPlace.daily, BarakahPlace.over}),
  BarakahText(id: 'q_talaq7', kind: BarakahKind.quran, text: 'لِيُنفِقْ ذُو سَعَةٍ مِّن سَعَتِهِ', source: 'الطلاق: 7', note: 'كل واحد يصرف على قد حاله.', places: {BarakahPlace.payday, BarakahPlace.over}),
  BarakahText(id: 'q_ibrahim7', kind: BarakahKind.quran, text: '…لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ', source: 'إبراهيم: 7', places: {BarakahPlace.payday, BarakahPlace.daily}),
  BarakahText(id: 'q_araf96', kind: BarakahKind.quran, text: 'وَلَوْ أَنَّ أَهْلَ الْقُرَىٰ آمَنُوا وَاتَّقَوْا لَفَتَحْنَا عَلَيْهِم بَرَكَاتٍ مِّنَ السَّمَاءِ وَالْأَرْضِ', source: 'الأعراف: 96', note: 'البركة تجي ويا الإيمان والتقوى.', places: {BarakahPlace.daily}),
  BarakahText(id: 'q_araf31', kind: BarakahKind.quran, text: '…وَكُلُوا وَاشْرَبُوا وَلَا تُسْرِفُوا ۚ إِنَّهُ لَا يُحِبُّ الْمُسْرِفِينَ', source: 'الأعراف: 31', places: {BarakahPlace.over}),
  BarakahText(id: 'q_furqan67', kind: BarakahKind.quran, text: 'وَالَّذِينَ إِذَا أَنفَقُوا لَمْ يُسْرِفُوا وَلَمْ يَقْتُرُوا وَكَانَ بَيْنَ ذَٰلِكَ قَوَامًا', source: 'الفرقان: 67', note: 'لا إسراف ولا تقتير: هذا هو الوسط اللي نحاول عليه كل أسبوع.', places: {BarakahPlace.over, BarakahPlace.daily, BarakahPlace.payday}),
  BarakahText(id: 'q_isra26', kind: BarakahKind.quran, text: '…وَلَا تُبَذِّرْ تَبْذِيرًا ۝ إِنَّ الْمُبَذِّرِينَ كَانُوا إِخْوَانَ الشَّيَاطِينِ', source: 'الإسراء: 26–27', places: {BarakahPlace.over}),
  BarakahText(id: 'q_isra29', kind: BarakahKind.quran, text: 'وَلَا تَجْعَلْ يَدَكَ مَغْلُولَةً إِلَىٰ عُنُقِكَ وَلَا تَبْسُطْهَا كُلَّ الْبَسْطِ فَتَقْعُدَ مَلُومًا مَّحْسُورًا', source: 'الإسراء: 29', places: {BarakahPlace.over}),
  BarakahText(id: 'q_nuh10', kind: BarakahKind.quran, text: 'فَقُلْتُ اسْتَغْفِرُوا رَبَّكُمْ إِنَّهُ كَانَ غَفَّارًا ۝ يُرْسِلِ السَّمَاءَ عَلَيْكُم مِّدْرَارًا ۝ وَيُمْدِدْكُم بِأَمْوَالٍ وَبَنِينَ…', source: 'نوح: 10–12', note: 'الاستغفار من أسباب الرزق.', places: {BarakahPlace.daily}),
  BarakahText(id: 'q_tawba103', kind: BarakahKind.quran, text: 'خُذْ مِنْ أَمْوَالِهِمْ صَدَقَةً تُطَهِّرُهُمْ وَتُزَكِّيهِم بِهَا', source: 'التوبة: 103', places: {BarakahPlace.zakat}),
  BarakahText(id: 'q_tawba60', kind: BarakahKind.quran, text: 'إِنَّمَا الصَّدَقَاتُ لِلْفُقَرَاءِ وَالْمَسَاكِينِ وَالْعَامِلِينَ عَلَيْهَا وَالْمُؤَلَّفَةِ قُلُوبُهُمْ وَفِي الرِّقَابِ وَالْغَارِمِينَ وَفِي سَبِيلِ اللَّهِ وَابْنِ السَّبِيلِ ۖ فَرِيضَةً مِّنَ اللَّهِ', source: 'التوبة: 60', note: 'هذولة الثمانية اللي تنطى إلهم الزكاة.', places: {BarakahPlace.zakat}),
  BarakahText(id: 'q_munafiqun10', kind: BarakahKind.quran, text: 'وَأَنفِقُوا مِن مَّا رَزَقْنَاكُم مِّن قَبْلِ أَن يَأْتِيَ أَحَدَكُمُ الْمَوْتُ…', source: 'المنافقون: 10', places: {BarakahPlace.sadaqa, BarakahPlace.friday}),
  BarakahText(id: 'q_hud6', kind: BarakahKind.quran, text: 'وَمَا مِن دَابَّةٍ فِي الْأَرْضِ إِلَّا عَلَى اللَّهِ رِزْقُهَا', source: 'هود: 6', places: {BarakahPlace.daily}),
  BarakahText(id: 'h_naqasat', kind: BarakahKind.hadith, text: 'ما نقصت صدقة من مال', source: 'رواه مسلم (2588)', places: {BarakahPlace.sadaqa, BarakahPlace.friday, BarakahPlace.daily}),
  BarakahText(id: 'h_bayyiaan', kind: BarakahKind.hadith, text: 'البيعان بالخيار ما لم يتفرقا… فإن صدقا وبيّنا بورك لهما في بيعهما، وإن كتما وكذبا محقت بركة بيعهما', source: 'رواه البخاري (2079) ومسلم (1532)', note: 'الصدق بالبيع والشراء من أسباب البركة.', places: {BarakahPlace.daily}),
  BarakahText(id: 'h_rahim', kind: BarakahKind.hadith, text: 'من أحب أن يُبسط له في رزقه، ويُنسأ له في أثره، فليصل رحمه', source: 'رواه البخاري (5986) ومسلم (2557)', note: 'صلة الرحم من أسباب سعة الرزق.', places: {BarakahPlace.daily, BarakahPlace.family}),
  BarakahText(id: 'h_ghina', kind: BarakahKind.hadith, text: 'ليس الغنى عن كثرة العَرَض، ولكن الغنى غنى النفس', source: 'رواه البخاري (6446) ومسلم (1051)', places: {BarakahPlace.daily, BarakahPlace.over}),
  BarakahText(id: 'h_yad_ulya', kind: BarakahKind.hadith, text: 'اليد العليا خير من اليد السفلى، وابدأ بمن تعول', source: 'رواه البخاري (1427)', places: {BarakahPlace.kid, BarakahPlace.payday, BarakahPlace.family}),
  BarakahText(id: 'h_dinar_ahl', kind: BarakahKind.hadith, text: 'دينار أنفقته في سبيل الله… ودينار أنفقته على أهلك، أعظمها أجرًا الذي أنفقته على أهلك', source: 'رواه مسلم (995)', note: 'مصروف البيت اللي تسجلونه هنا، أجره عظيم.', places: {BarakahPlace.family, BarakahPlace.payday}),
  BarakahText(id: 'h_nafaqa_ahl', kind: BarakahKind.hadith, text: 'إذا أنفق المسلم نفقة على أهله وهو يحتسبها كانت له صدقة', source: 'رواه البخاري (5351) ومسلم (1002) بنحوه', places: {BarakahPlace.family}),
  BarakahText(id: 'h_fam_imraatik', kind: BarakahKind.hadith, text: 'إنك لن تنفق نفقة تبتغي بها وجه الله إلا أُجرت عليها، حتى ما تجعل في فم امرأتك', source: 'رواه البخاري (56)', places: {BarakahPlace.family}),
  BarakahText(id: 'h_yahbis', kind: BarakahKind.hadith, text: 'كفى بالمرء إثمًا أن يحبس عمّن يملك قوته', source: 'رواه مسلم (996)', places: {BarakahPlace.family}),
  BarakahText(id: 'h_taam', kind: BarakahKind.hadith, text: 'طعام الاثنين كافي الثلاثة، وطعام الثلاثة كافي الأربعة', source: 'رواه البخاري (5392) ومسلم (2058)', note: 'الأكل المشترك بيه بركة.', places: {BarakahPlace.daily}),
  BarakahText(id: 'h_kilu', kind: BarakahKind.hadith, text: 'كيلوا طعامكم يُبارك لكم', source: 'رواه البخاري (2128)', note: 'قال ابن بطال في شرحه: «الكيل مندوب إليه فيما ينفقه المرء على عياله».', places: {BarakahPlace.daily, BarakahPlace.payday}),
  BarakahText(id: 'h_bukur', kind: BarakahKind.hadith, text: 'اللهم بارك لأمتي في بكورها', source: 'رواه أبو داود (2606) والترمذي (1212)', grade: 'قال الترمذي: حسن', places: {BarakahPlace.daily}),
  BarakahText(id: 'h_akhadha', kind: BarakahKind.hadith, text: 'من أخذ أموال الناس يريد أداءها أدّى الله عنه، ومن أخذ يريد إتلافها أتلفه الله', source: 'رواه البخاري (2387)', places: {BarakahPlace.debt}),
  BarakahText(id: 'h_matl', kind: BarakahKind.hadith, text: 'مطل الغني ظلم', source: 'رواه البخاري (2287) ومسلم (1564)', note: 'اللي يگدر يسدّ دينه وما يسدّه، ظالم.', places: {BarakahPlace.debt}),
  BarakahText(id: 'h_muallaqa', kind: BarakahKind.hadith, text: 'نفس المؤمن معلقة بدينه حتى يُقضى عنه', source: 'رواه الترمذي (1078)', grade: 'قال الترمذي: حسن', places: {BarakahPlace.debt}),
  BarakahText(id: 'h_muassir', kind: BarakahKind.hadith, text: 'ومن يسّر على معسر يسّر الله عليه في الدنيا والآخرة', source: 'رواه مسلم (2699)', places: {BarakahPlace.debt}),
  BarakahText(id: 'h_tajir', kind: BarakahKind.hadith, text: 'كان تاجر يداين الناس، فإذا رأى معسرًا قال لفتيانه: تجاوزوا عنه لعل الله أن يتجاوز عنا، فتجاوز الله عنه', source: 'رواه البخاري (2078) ومسلم (1562)', places: {BarakahPlace.debt}),
  BarakahText(id: 'h_khadira', kind: BarakahKind.hadith, text: 'إن هذا المال خضرة حلوة، فمن أخذه بسخاوة نفس بورك له فيه…', source: 'رواه البخاري (1472) ومسلم (1035) بنحوه', places: {BarakahPlace.daily, BarakahPlace.payday}),
  BarakahText(id: 'h_tawakkul', kind: BarakahKind.hadith, text: 'لو أنكم كنتم توكلون على الله حق توكله لرُزقتم كما تُرزق الطير، تغدو خماصًا وتروح بطانًا', source: 'رواه الترمذي (2344)', grade: 'قال الترمذي: حسن صحيح', places: {BarakahPlace.daily, BarakahPlace.over}),
  BarakahText(id: 'h_malakan', kind: BarakahKind.hadith, text: 'ما من يوم يصبح العباد فيه إلا ملكان ينزلان، فيقول أحدهما: اللهم أعطِ منفقًا خلفًا، ويقول الآخر: اللهم أعطِ ممسكًا تلفًا', source: 'رواه البخاري (1442) ومسلم (1010)', places: {BarakahPlace.friday, BarakahPlace.sadaqa}),
  BarakahText(id: 'h_tamra', kind: BarakahKind.hadith, text: 'اتقوا النار ولو بشق تمرة', source: 'رواه البخاري (1417) ومسلم (1016)', note: 'الصدقة الصغيرة تنحسب.', places: {BarakahPlace.friday, BarakahPlace.kid, BarakahPlace.sadaqa}),
  BarakahText(id: 'h_akhfaha', kind: BarakahKind.hadith, text: 'سبعة يظلهم الله في ظله… ورجل تصدّق بصدقة فأخفاها حتى لا تعلم شماله ما تنفق يمينه', source: 'رواه البخاري (1423)', places: {BarakahPlace.sadaqa}),
  BarakahText(id: 'h_tutfi', kind: BarakahKind.hadith, text: 'الصدقة تطفئ الخطيئة كما يطفئ الماء النار', source: 'رواه الترمذي (2616)', grade: 'قال الترمذي: حسن صحيح', places: {BarakahPlace.sadaqa}),
  BarakahText(id: 'h_sahih_shahih', kind: BarakahKind.hadith, text: 'أن تصدّق وأنت صحيح شحيح تخشى الفقر وتأمل الغنى', source: 'رواه البخاري (1419) ومسلم (1032)', note: 'جواب: أي الصدقة أعظم أجرًا؟', places: {BarakahPlace.friday, BarakahPlace.payday}),
  BarakahText(id: 'h_adwamuha', kind: BarakahKind.hadith, text: 'أحب الأعمال إلى الله أدومها وإن قل', source: 'رواه البخاري (6464) ومسلم (783)', note: 'لهذا ظرف الصدقة الصغير الدايم.', places: {BarakahPlace.sadaqa, BarakahPlace.friday, BarakahPlace.payday}),
  BarakahText(id: 'h_maruf', kind: BarakahKind.hadith, text: 'كل معروف صدقة', source: 'رواه البخاري (6021) ومسلم (1005)', places: {BarakahPlace.kid, BarakahPlace.daily}),
  BarakahText(id: 'h_dhi_rahim', kind: BarakahKind.hadith, text: 'الصدقة على المسكين صدقة، وهي على ذي الرحم ثنتان: صدقة وصلة', source: 'رواه الترمذي (658)', grade: 'قال الترمذي: حسن', places: {BarakahPlace.sadaqa, BarakahPlace.family}),
  BarakahText(id: 'h_amin', kind: BarakahKind.hadith, text: 'من أصبح منكم آمنًا في سربه، معافى في جسده، عنده قوت يومه، فكأنما حيزت له الدنيا', source: 'رواه الترمذي (2346)', grade: 'قال الترمذي: حسن غريب، وحسّنه الألباني', places: {BarakahPlace.daily, BarakahPlace.over}),
  BarakahText(id: 'h_asfal', kind: BarakahKind.hadith, text: 'انظروا إلى من أسفل منكم، ولا تنظروا إلى من هو فوقكم، فهو أجدر أن لا تزدروا نعمة الله', source: 'رواه مسلم (2963)', places: {BarakahPlace.over, BarakahPlace.daily}),
  BarakahText(id: 'h_aflaha', kind: BarakahKind.hadith, text: 'قد أفلح من أسلم، ورُزق كفافًا، وقنّعه الله بما آتاه', source: 'رواه مسلم (1054)', places: {BarakahPlace.daily, BarakahPlace.over}),
  BarakahText(id: 'h_tazul', kind: BarakahKind.hadith, text: 'لا تزول قدما عبد يوم القيامة حتى يُسأل… وعن ماله من أين اكتسبه وفيمَ أنفقه…', source: 'رواه الترمذي (2417)', grade: 'قال الترمذي: حسن صحيح', note: '«وين فلوسي؟» سؤال راح ننسأله، فخلّينا نعرف جوابه من هسه.', places: {BarakahPlace.daily, BarakahPlace.payday}),
  BarakahText(id: 'h_amal_yad', kind: BarakahKind.hadith, text: 'ما أكل أحد طعامًا قط خيرًا من أن يأكل من عمل يده', source: 'رواه البخاري (2072)', places: {BarakahPlace.kid, BarakahPlace.payday}),
  BarakahText(id: 'h_warathatak', kind: BarakahKind.hadith, text: 'إنك أن تذر ورثتك أغنياء خير من أن تذرهم عالة يتكففون الناس', source: 'رواه البخاري (1295) ومسلم (1628)', note: 'الادّخار للعائلة (الخزنة) بيه خير.', places: {BarakahPlace.payday, BarakahPlace.family}),
  BarakahText(id: 'h_mal_salih', kind: BarakahKind.hadith, text: 'يا عمرو، نعم المال الصالح للمرء الصالح', source: 'رواه البخاري في الأدب المفرد، وابن حبان (3210)', grade: 'صححه الألباني', places: {BarakahPlace.daily}),
  BarakahText(id: 'h_fitr', kind: BarakahKind.hadith, text: 'فرض رسول الله ﷺ زكاة الفطر صاعًا من تمر أو صاعًا من شعير على العبد والحر والذكر والأنثى والصغير والكبير من المسلمين، وأمر بها أن تؤدّى قبل خروج الناس إلى الصلاة', source: 'رواه البخاري (1503) ومسلم (984) بنحوه', places: {BarakahPlace.fitr}),
  BarakahText(id: 'h_khams_awaq', kind: BarakahKind.hadith, text: 'ليس فيما دون خمس أواق صدقة', source: 'رواه البخاري (1447) ومسلم (979)', note: 'خمس أواق = 200 درهم، وهي نصاب الفضة.', places: {BarakahPlace.zakat}),
  BarakahText(id: 'h_ishrun_dinar', kind: BarakahKind.hadith, text: '…وليس عليك شيء -يعني في الذهب- حتى يكون لك عشرون دينارًا، فإذا كان لك عشرون دينارًا وحال عليها الحول ففيها نصف دينار', source: 'رواه أبو داود (1573)', grade: 'صححه الألباني، وحسّنه ابن حجر مع الخلاف في رفعه', note: 'عشرون دينارًا = 85 غرام ذهب، وهذا نصاب الذهب، ونصف دينار منها هو ربع العُشر.', places: {BarakahPlace.zakat}),
  BarakahText(id: 'h_kafiuhu', kind: BarakahKind.hadith, text: 'من صنع إليكم معروفًا فكافئوه، فإن لم تجدوا ما تكافئونه فادعوا له حتى تروا أنكم قد كافأتموه', source: 'رواه أبو داود (1672)', grade: 'صححه الألباني', places: {BarakahPlace.family, BarakahPlace.debt}),
  BarakahText(id: 'd_hamm', kind: BarakahKind.dua, text: 'اللهم إني أعوذ بك من الهم والحزن، والعجز والكسل، والجبن والبخل، وضلع الدين وغلبة الرجال', source: 'رواه البخاري (6369)', places: {BarakahPlace.debt, BarakahPlace.over}),
  BarakahText(id: 'd_ikfini', kind: BarakahKind.dua, text: 'اللهم اكفني بحلالك عن حرامك، وأغنني بفضلك عمّن سواك', source: 'رواه الترمذي (3563)', grade: 'قال الترمذي: حسن غريب، وحسّنه الألباني', places: {BarakahPlace.payday, BarakahPlace.debt}),
  BarakahText(id: 'd_ilman', kind: BarakahKind.dua, text: 'اللهم إني أسألك علمًا نافعًا، ورزقًا طيبًا، وعملًا متقبّلًا', source: 'رواه ابن ماجه (925)، يُقال بعد صلاة الصبح', grade: 'حسّنه ابن حجر، وصححه الألباني', places: {BarakahPlace.payday, BarakahPlace.daily}),
];
