# بحث الإدخال السريع وميزات العائلة (تشرين الأول 2026)

النموذج التفاعلي: `design/E2-rizma-prototype.html`. النسخة الأولى باقية: `design/E-rizma-prototype.html`.

## الخلاصة
- أكبر خطر على التطبيق: الناس تبطّل تسجّل. بأحد التطبيقات، 83% من اللي بدوا يسجلون وقفوا خلال شهر.
- الحل المدعوم بالأدلة: الجهاز يلتقط الصرفة وحده، والإنسان يأكّدها بدوسة. التتبع الكامل الآلي يضيّع الوعي بالصرف، واليدوي الكامل متعب.
- للكاش: عدّ الجيب (كم بقى) بدل تسجيل كل صرفة، والفرق ينسجل وحده.

## طرق الإدخال (مرتّبة حسب الأثر المتوقع)
1. **رسائل الكي كارد تتسجل وحدها**، وتنتظر تأكيد بدوسة أو سحبة، والتطبيق يخمّن الباب.
   - سياسة Google Play الحالية تسمح بقراءة الرسائل لفئة «SMS-based money management, e.g. apps that track and manage budget». تحتاج تعبئة استمارة Permissions Declaration.
   - المصدر: https://support.google.com/googleplay/android-developer/answer/10208820
   - البديل إذا انرفض الطلب: قراءة الإشعارات (NotificationListenerService) بموافقة المستخدم.
   - **غير متحقق بعد:** شكل رسالة الكي كارد الفعلية. نحتاج نماذج حقيقية من موبايلكم قبل كتابة القارئ.
2. **عدّ الجيب للكاش.** نفس فكرة التسوية بتطبيق YNAB، والمذكرات المالية مثل Portfolios of the Poor. ما لقينا دراسة مباشرة على هذي الطريقة كتطبيق.
3. **السحب من الكي كارد = تحويل للجيب، مو صرف.** كل دينار ينحسب بدون تسجيل إضافي.
4. **ويدجت على الشاشة الرئيسية.** تطبيق واحد (Gratitude) نشر زيادة 25% بالاستمرار عند مستخدمي الويدجت. https://android-developers.googleblog.com/2026/05/how-gratitude-widgets-boosted-user-retention-25-percent.html
5. **المتكرر بدوسة وحدة، والفواتير الثابتة تنحسب وحدها.**
6. **تذكير واحد بعد العشا للاثنين** بصيغة «لما يصير كذا، نسوي كذا»، والمعروفة علمياً بـ«نية التنفيذ» (حجم الأثر d=0.65). تذكير زيادة ما يضيف شي.
7. **دفتر مشترك للعائلة، بس المصروف الحر لكل واحد ما تبين تفاصيله.**
8. **الكتابة والصوت باللهجة، وكم صرفة بجملة وحدة.**
   - مثال: «صمون 2 وخضرة 5 وبنزين 25». و«ورقة» تعني 100 دولار.
   - قواعد محلية تشتغل أول شي. الذكاء الاصطناعي (Claude) بس للجمل الغامضة، ويرجع JSON منظم.
   - دقة التعرف على صوت اللهجة العراقية لسه ما مقاسة. لازم نختبرها.

## حدود وأشياء ما تنفع هسه
- **قراءة الوصولات بالكاميرا:** ML Kit من Google ما يدعم العربي (https://developers.google.com/ml-kit/vision/text-recognition/v2/languages). أولوية منخفضة، وإذا احتجناها تكون عبر الذكاء الاصطناعي بالسيرفر.
- **عرض الباقي بالضبط قرب نهاية الفترة ممكن يزيد الصرف.** خففناه بثلاث أشياء: فترة أسبوع بدل شهر، الباقي يروح للخزنة، ورقم «كل يوم حوالي».
- **السلاسل (Streaks):** إذا استعملناها لازم تكون قابلة للإصلاح. انكسار السلسلة يقلل الاستمرار.

## ميزات العائلة
- **حساب الطفل:**
  - ثلاث جرار بالصور: اصرف، احفظ، صدقة.
  - صورة الهدف ومعها شريط يتعبى.
  - بابا يضيف 500 على كل ألف (ما لقينا تجربة على أطفال، بس المطابقة رفعت الادخار عند الكبار: Duflo 2006).
  - قعدة أسبوعية ويا الطفل، لأن نقاش الفلوس ويا الأهل مرتبط بنتائج أحسن بـPISA.
  - ما ندّعي إنه «يبني قوة إرادة».
- **الجمعية:**
  - بالعراق، 21.7% ادخروا عبر نادي أو شخص من برّه العائلة (Findex 2014، غير موزون).
  - نسجّل: الأعضاء، المسؤولة، المبلغ، ترتيب الأدوار، تاريخ كل دور، دفعات كل جولة، ودورنا.
  - تنبيه إذا أحد قبض دوره وتأخر بالدفع.
  - ما نمسك ولا ننقل فلوس.
- **الديون:**
  - رصيد لكل شخص، تسديد جزئي، وخيار «سامحناه».
  - التذكير اختياري، مؤدب، باسم الشخص، ويتعدّل قبل الإرسال بالواتساب. التذكير الشخصي أنجح من العام.
- **الفواتير:**
  - تذكير واحد قبل الموعد باسم الفاتورة.
  - المولدة = عدد الأمبيرات × سعر الأمبير، والسعر يتعدّل.
  - بغداد أيار 2026: التسعيرة الرسمية 12,000 للأمبير، والفعلي 20–25 ألف. https://www.kurdistan24.net/ar/story/912039
- **الزوجين:** صندوق مشترك واضح، ومصروف حر متساوي لكل واحد. الحساب المشترك حافظ على جودة العلاقة بتجربة عشوائية (Olson et al. 2023).

## المصادر الرئيسية
- Choe et al., semi-automated tracking: http://faculty.washington.edu/jkientz/papers/Choe-SemiAutomatedTracking-Pervasive2017.pdf
- Epstein et al. 2015, lived informatics: https://my.eng.utah.edu/~cs5540/au16/readings/PersonalInformatics-Epstein2015.pdf
- UW–Madison, expense-tracking logs: https://asset.library.wisc.edu/1711.dl/63XZYPDLKMY638S/R/file-908a3.pdf
- Budget feedback backfire: https://cepr.org/system/files/2022-08/Dynamic%20Budget%20Monitoring%20-%20When%20Access%20to%20Budget%20Feedback%20Leads%20to%20Increase%20in%20Spending%20-%20Anastasiya%20Pocheptsova%20Ghosh%20&%20Liang%20Huang.pdf
- Silverman & Barasch, streaks: https://knowledge.insead.edu/marketing/consumer-streaks-are-motivating-the-key-is-keeping-them-alive-19011
- Karlan et al., reminders: https://www.povertyactionlab.org/media/file-research-paper/getting-top-mind-how-reminders-increase-saving
- Medina 2021, side effects of reminders: https://ideas.repec.org/a/oup/rfinst/v34y2021i5p2580-2607..html
- Gugerty 2007, ROSCAs: https://www.journals.uchicago.edu/doi/abs/10.1086/508716
- Findex 2014 Iraq: https://microdata.worldbank.org/catalog/2435/variable/F1/V36?name=q18b
- Olson et al. 2023, joint accounts: https://som.yale.edu/node/274161
- OECD PISA 2022 Vol. IV: https://oecd.org/en/publications/pisa-2022-results-volume-iv_5a849c2a-en/full-report/component-11.html
- Duflo et al. 2006, match: https://www.povertyactionlab.org/evaluation/saving-incentives-low-and-middle-income-families-evidence-field-experiment-hr-block
