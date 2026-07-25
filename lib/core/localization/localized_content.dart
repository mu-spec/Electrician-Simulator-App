import 'package:flutter/material.dart';
import '../../models/calculator_model.dart';
import '../../models/pakistan_standard.dart';
import '../../models/quiz_model.dart';
import '../../models/theory_article.dart';
import '../../models/wiring_diagram.dart';
import 'app_localizations.dart';
import 'data_translations.dart';

class LocalizedContent {
  static String code(BuildContext context) => AppLocalizations.of(context).code;
  static bool isEnglish(BuildContext context) => code(context) == 'en';
  static bool isUrdu(BuildContext context) => code(context) == 'ur';

  static String _pick(BuildContext context, Map<String, String> values, String fallback) {
    return values[code(context)] ?? values['en'] ?? fallback;
  }

  
  static String _translate(BuildContext context, String text) {
    if (isEnglish(context)) return text;
    final langCode = code(context);
    return DataTranslations.translate(langCode, text) ?? _localize(context, text);
  }

  /// Exact translation entry point for dynamic content rendered by screens.
  static String text(BuildContext context, String english) =>
      _translate(context, english);

  static List<String> textList(BuildContext context, Iterable<String> english) =>
      english.map((item) => _translate(context, item)).toList();

  static String _localize(BuildContext context, String text) {
    if (isEnglish(context)) return text;
    var output = text;
    final dict = _technicalTerms[code(context)] ?? const <String, String>{};
    final keys = dict.keys.toList()..sort((a, b) => b.length.compareTo(a.length));
    for (final key in keys) {
      output = output.replaceAll(RegExp(RegExp.escape(key), caseSensitive: false), dict[key]!);
    }
    return output;
  }

  // Categories
  static String theoryCategoryName(BuildContext context, String id, String fallback) => _translate(context, fallback);

  static String calculatorCategoryName(BuildContext context, String id, String fallback) => _translate(context, fallback);

  static String wiringCategoryName(BuildContext context, String id, String fallback) => _translate(context, fallback);

  static String quizCategoryName(BuildContext context, QuizCategory category) => _translate(context, category.name);

  static String quizCategoryDescription(BuildContext context, QuizCategory category) =>
      _translate(context, category.description);

  static String standardCategoryName(BuildContext context, String id, String fallback) => _translate(context, fallback);

  // Theory
  static String articleTitle(BuildContext context, TheoryArticle article) => _translate(context, article.title);

  static String articleSummary(BuildContext context, TheoryArticle article) =>
      _translate(context, article.summary);

  static String articleContent(BuildContext context, TheoryArticle article) =>
      _translate(context, article.content);

  // Calculators
  static String calculatorName(BuildContext context, CalculatorModel calculator) => _translate(context, calculator.name);

  static String calculatorDescription(BuildContext context, CalculatorModel calculator) =>
      _translate(context, calculator.description);

  static String calculatorFieldLabel(BuildContext context, String label) => _translate(context, label);
  static String calculatorFieldHint(BuildContext context, String hint) => _translate(context, hint);
  static String calculatorOutputLabel(BuildContext context, String label) => _translate(context, label);
  static String calculatorOutputDescription(BuildContext context, String description) => _translate(context, description);

  static String calculatorValidationMessage(
    BuildContext context,
    String fieldLabel,
    String rule,
  ) {
    final field = calculatorFieldLabel(context, fieldLabel);
    final source = rule == 'required'
        ? 'Please enter {field}.'
        : 'Please enter a valid value for {field}.';
    return _translate(context, source).replaceAll('{field}', field);
  }

  static String calculatorRangeMessage(
    BuildContext context,
    String fieldLabel,
    num value, {
    required bool minimum,
  }) {
    final field = calculatorFieldLabel(context, fieldLabel);
    final source = minimum
        ? '{field} must be at least {value}.'
        : '{field} must be no more than {value}.';
    return _translate(context, source)
        .replaceAll('{field}', field)
        .replaceAll('{value}', '$value');
  }

  // Wiring
  static String wiringTitle(BuildContext context, WiringDiagram diagram) =>
      _translate(context, diagram.title);
  static String wiringDescription(BuildContext context, WiringDiagram diagram) =>
      _translate(context, diagram.description);
  static List<String> wiringComponents(BuildContext context, WiringDiagram diagram) =>
      textList(context, diagram.components);
  static List<String> wiringSafetyWarnings(BuildContext context, WiringDiagram diagram) =>
      textList(context, diagram.safetyWarnings);
  static List<String> wiringCommonMistakes(BuildContext context, WiringDiagram diagram) =>
      textList(context, diagram.commonMistakes);
  static List<String> wiringTestingProcedure(BuildContext context, WiringDiagram diagram) =>
      textList(context, diagram.testingProcedure);
  static List<String> wiringProfessionalNotes(BuildContext context, WiringDiagram diagram) =>
      textList(context, diagram.professionalNotes);
  static List<String> wiringSteps(BuildContext context, WiringDiagram diagram) =>
      textList(context, diagram.steps);

  // Quiz
  static String quizQuestion(BuildContext context, QuizQuestion question) =>
      _translate(context, question.question);
  static List<String> quizOptions(BuildContext context, QuizQuestion question) =>
      textList(context, question.options);
  static String quizExplanation(BuildContext context, QuizQuestion question) =>
      _translate(context, question.explanation);

  static String quizDifficulty(BuildContext context, String difficulty) {
    if (isEnglish(context)) return difficulty.toUpperCase();
    final d = difficulty.toLowerCase();
    final map = _difficulty[d];
    return map?[code(context)] ?? difficulty.toUpperCase();
  }

  // Standards
  static String standardTitle(BuildContext context, PakistanStandard standard) => _translate(context, standard.title);
  static String standardSummary(BuildContext context, PakistanStandard standard) => _translate(context, standard.summary);
  static List<String> standardKeyPoints(BuildContext context, PakistanStandard standard) =>
      textList(context, standard.keyPoints);
  static List<String> standardFieldChecklist(BuildContext context, PakistanStandard standard) =>
      textList(context, standard.fieldChecklist);
  static List<String> standardWarnings(BuildContext context, PakistanStandard standard) =>
      textList(context, standard.warnings);

  static List<String> _standardsList(BuildContext context, String type, List<String> fallback) {
    final templates = _standardsListTemplates[code(context)];
    final localized = templates?[type];
    if (localized != null) return localized;
    if (type == 'keyPoints') {
      return [_codePoint(context), _verifyPoint(context), _recordPoint(context)];
    }
    if (type == 'checklist') {
      return [_codePoint(context), _safeWorkPoint(context), _recordPoint(context)];
    }
    if (type == 'warnings') {
      return [_mistakePoint(context), _qualifiedPoint(context)];
    }
    return fallback.map((e) => _localize(context, e)).toList();
  }

  // Generic text
  static String _genericDescription(BuildContext context, String topic) => _pick(context, {
    'en': 'This section explains $topic with practical use and safety guidance.',
    'ur': 'یہ سیکشن $topic کی عملی وضاحت اور حفاظتی رہنمائی فراہم کرتا ہے۔',
    'hi': 'यह अनुभाग $topic की व्यावहारिक व्याख्या और सुरक्षा मार्गदर्शन देता है।',
    'ar': 'يوضح هذا القسم $topic مع إرشادات السلامة والاستخدام العملي.',
    'es': 'Esta sección explica $topic con uso práctico y seguridad.',
    'pt': 'Esta seção explica $topic com uso prático e segurança.',
    'fr': 'Cette section explique $topic avec usage pratique et sécurité.',
    'de': 'Dieser Abschnitt erklärt $topic mit Praxis und Sicherheit.',
    'ru': 'Этот раздел объясняет $topic, практику и безопасность.',
    'zh': '本节介绍 $topic 的实际用途和安全要点。',
    'tr': 'Bu bölüm $topic konusunu pratik ve güvenlikle açıklar.',
    'id': 'Bagian ini menjelaskan $topic dengan praktik dan keselamatan.',
    'bn': 'এই অংশে $topic এর ব্যবহারিক ও নিরাপত্তা দিক ব্যাখ্যা করা হয়েছে।',
    'fa': 'این بخش $topic را همراه با کاربرد عملی و ایمنی توضیح می‌دهد.',
    'ms': 'Bahagian ini menerangkan $topic dengan amalan dan keselamatan.',
    'it': 'Questa sezione spiega $topic con uso pratico e sicurezza.',
    'ja': 'このセクションでは、$topic を実務と安全の観点から説明します。',
    'ko': '이 섹션은 $topic 을(를) 실무와 안전 지침과 함께 설명합니다.',
    'vi': 'Phần này giải thích $topic với hướng dẫn thực tế và an toàn.',
    'th': 'ส่วนนี้อธิบาย $topic พร้อมการใช้งานจริงและคำแนะนำด้านความปลอดภัย',
    'pl': 'Ta sekcja wyjaśnia $topic z praktyką i wskazówkami bezpieczeństwa.',
    'nl': 'Deze sectie legt $topic uit met praktische en veiligheidsrichtlijnen.',
    'uk': 'Цей розділ пояснює $topic з практикою та порадами з безпеки.',
    'ro': 'Această secțiune explică $topic cu utilizare practică și siguranță.',
    'sv': 'Detta avsnitt förklarar $topic med praktisk användning och säkerhet.',
    'hu': 'Ez a szakasz a(z) $topic témát gyakorlati és biztonsági útmutatóval magyarázza.',
    'cs': 'Tato sekce vysvětluje $topic s praktickým použitím a bezpečností.',
    'el': 'Αυτή η ενότητα εξηγεί το $topic με πρακτική χρήση και ασφάλεια.',
    'bg': 'Този раздел обяснява $topic с практическо приложение и безопасност.',
    'da': 'Dette afsnit forklarer $topic med praktisk brug og sikkerhed.',
    'fi': 'Tämä osio selittää aiheen $topic käytännön ja turvallisuuden kannalta.',
    'no': 'Denne delen forklarer $topic med praktisk bruk og sikkerhet.',
    'sk': 'Táto sekcia vysvetľuje $topic s praktickým použitím a bezpečnosťou.',
    'hr': 'Ovaj odjeljak objašnjava $topic s praktičnom upotrebom i sigurnošću.',
    'sr': 'Овај одељак објашњава $topic уз практичну употребу и безбедност.',
    'ta': 'இந்தப் பகுதி $topic ஐ நடைமுறை பயன்பாடு மற்றும் பாதுகாப்புடன் விளக்குகிறது.',
    'te': 'ఈ విభాగం $topic ను ఆచరణాత్మక ఉపయోగం మరియు భద్రతతో వివరిస్తుంది.',
    'kn': 'ಈ ವಿಭಾಗವು $topic ಅನ್ನು ಪ್ರಾಯೋಗಿಕ ಬಳಕೆ ಮತ್ತು ಸುರಕ್ಷತೆಯೊಂದಿಗೆ ವಿವರಿಸುತ್ತದೆ.',
    'mr': 'हा विभाग $topic चे व्यावहारिक उपयोग आणि सुरक्षिततेसह स्पष्टीकरण देतो.',
    'gu': 'આ વિભાગ $topic ને વ્યવહારિક ઉપયોગ અને સુરક્ષા સાથે સમજાવે છે.',
    'pa': 'ਇਹ ਭਾਗ $topic ਨੂੰ ਅਮਲੀ ਵਰਤੋਂ ਅਤੇ ਸੁਰੱਖਿਆ ਨਾਲ ਸਮਝਾਉਂਦਾ ਹੈ।',
    'sw': 'Sehemu hii inaeleza $topic kwa matumizi ya vitendo na usalama.',
    'tl': 'Ipinapaliwanag ng seksyong ito ang $topic na may praktikal na paggamit at kaligtasan.',
    'he': 'סעיף זה מסביר את $topic עם שימוש מעשי והנחיות בטיחות.',
    'az': 'Bu bölmə $topic mövzusunu praktiki istifadə və təhlükəsizliklə izah edir.',
    'uz': 'Bu bo‘lim $topic mavzusini amaliy foydalanish va xavfsizlik bilan tushuntiradi.',
    'my': 'ဤအပိုင်းသည် $topic ကို လက်တွေ့အသုံးပြုမှုနှင့် ဘေးကင်းရေးဖြင့် ရှင်းပြသည်။',
    'km': 'ផ្នែកនេះពន្យល់ $topic ជាមួយការប្រើប្រាស់ជាក់ស្តែង និងសុវត្ថិភាព។',
    'si': 'මෙම කොටස $topic ප්‍රායෝගික භාවිතය සහ ආරක්ෂාව සමඟ පැහැදිලි කරයි.',
    'am': 'ይህ ክፍል $topic ን በተግባራዊ አጠቃቀም እና ደህንነት ያብራራል።',
  }, topic);

  static String _genericCalculatorDescription(BuildContext context, String name) => _pick(context, {
    'en': 'Practical calculator for $name. Verify final results with standards and site conditions.',
    'ur': '$name کے لیے عملی کیلکولیٹر۔ حتمی نتیجہ standards اور site conditions سے verify کریں۔',
    'hi': '$name के लिए व्यावहारिक कैलकुलेटर। अंतिम परिणाम standards और site conditions से सत्यापित करें।',
    'ar': 'حاسبة عملية لـ $name. تحقق من النتائج حسب المعايير وظروف الموقع.',
    'es': 'Calculadora práctica para $name. Verifique resultados con normas y sitio.',
    'pt': 'Calculadora prática para $name. Verifique com normas e local.',
    'fr': 'Calculateur pratique pour $name. Vérifiez avec normes et site.',
    'de': 'Praktischer Rechner für $name. Mit Normen und Standort prüfen.',
    'ru': 'Практический калькулятор для $name. Проверьте по нормам и условиям.',
    'zh': '$name 的实用计算器。请按标准和现场条件核实。',
    'tr': '$name için pratik hesaplayıcı. Standartlar ve saha ile doğrulayın.',
    'id': 'Kalkulator praktis untuk $name. Verifikasi dengan standar dan lokasi.',
    'bn': '$name এর জন্য ব্যবহারিক ক্যালকুলেটর। standards ও site conditions দিয়ে যাচাই করুন।',
    'fa': 'ماشین‌حساب عملی برای $name. با استاندارد و شرایط محل بررسی کنید.',
    'ms': 'Kalkulator praktikal untuk $name. Sahkan dengan piawaian dan tapak.',
  }, name);

  static String _genericWiringDescription(BuildContext context, String title) => _pick(context, {
    'en': 'Educational wiring guide for $title. Isolate supply before work.',
    'ur': '$title کے لیے تعلیمی وائرنگ گائیڈ۔ کام سے پہلے supply isolate کریں۔',
    'hi': '$title के लिए शैक्षिक वायरिंग गाइड। काम से पहले supply अलग करें।',
    'ar': 'دليل توصيل تعليمي لـ $title. افصل التغذية قبل العمل.',
    'es': 'Guía educativa de cableado para $title. Aísle antes de trabajar.',
    'pt': 'Guia educativo de fiação para $title. Isole antes do trabalho.',
    'fr': 'Guide éducatif de câblage pour $title. Isolez avant travail.',
    'de': 'Lern-Verdrahtungsanleitung für $title. Vor Arbeit freischalten.',
    'ru': 'Учебная схема для $title. Отключите питание перед работой.',
    'zh': '$title 的教学接线指南。操作前请断电。',
    'tr': '$title için eğitim kablolama rehberi. Önce enerjiyi kesin.',
    'id': 'Panduan pengkabelan untuk $title. Putuskan suplai sebelum kerja.',
    'bn': '$title এর জন্য শিক্ষামূলক ওয়্যারিং গাইড। কাজের আগে supply বিচ্ছিন্ন করুন।',
    'fa': 'راهنمای سیم‌کشی آموزشی برای $title. قبل از کار برق را قطع کنید.',
    'ms': 'Panduan pendawaian untuk $title. Putuskan bekalan sebelum kerja.',
  }, title);

  static String _genericQuizExplanation(BuildContext context) => _pick(context, {
    'en': 'Verify the answer with formulas, safety rules, and field practice.',
    'ur': 'جواب کو formulas، safety rules اور field practice سے verify کریں۔',
    'hi': 'उत्तर को formulas, safety rules और field practice से सत्यापित करें।',
    'ar': 'تحقق من الإجابة بالمعادلات والسلامة والممارسة الميدانية.',
    'es': 'Verifique la respuesta con fórmulas, seguridad y práctica.',
    'pt': 'Verifique a resposta com fórmulas, segurança e prática.',
    'fr': 'Vérifiez avec formules, sécurité et pratique.',
    'de': 'Prüfen Sie mit Formeln, Sicherheit und Praxis.',
    'ru': 'Проверьте ответ по формулам, безопасности и практике.',
    'zh': '请用公式、安全规则和现场实践核实答案。',
    'tr': 'Cevabı formüller, güvenlik ve saha uygulamasıyla doğrulayın.',
    'id': 'Verifikasi jawaban dengan rumus, keselamatan, dan praktik.',
    'bn': 'উত্তরটি formulas, safety rules ও field practice দিয়ে যাচাই করুন।',
    'fa': 'پاسخ را با فرمول‌ها، ایمنی و عمل میدانی بررسی کنید.',
    'ms': 'Sahkan jawapan dengan formula, keselamatan dan amalan.',
  }, 'Verify the answer with formulas, safety rules, and field practice.');

  static String _genericStandardsDescription(BuildContext context) => _pick(context, {
    'en': 'Educational reference for standards and codes. Verify latest official requirements.',
    'ur': 'standards اور codes کے لیے تعلیمی حوالہ۔ تازہ official requirements verify کریں۔',
    'hi': 'standards और codes के लिए शैक्षिक संदर्भ। नवीनतम official requirements सत्यापित करें।',
    'ar': 'مرجع تعليمي للمعايير والأكواد. تحقق من أحدث المتطلبات الرسمية.',
    'es': 'Referencia educativa para normas y códigos. Verifique requisitos oficiales.',
    'pt': 'Referência educacional para normas e códigos. Verifique requisitos oficiais.',
    'fr': 'Référence éducative pour normes et codes. Vérifiez exigences officielles.',
    'de': 'Bildungsreferenz für Normen. Offizielle Anforderungen prüfen.',
    'ru': 'Учебная справка по стандартам. Проверьте официальные требования.',
    'zh': '标准与规范的教育参考。请核实官方要求。',
    'tr': 'Standartlar için eğitim referansı. Resmi gereklilikleri doğrulayın.',
    'id': 'Referensi edukasi standar dan kode. Verifikasi persyaratan resmi.',
    'bn': 'standards ও codes এর শিক্ষামূলক রেফারেন্স। official requirements যাচাই করুন।',
    'fa': 'مرجع آموزشی استانداردها و کدها. الزامات رسمی را بررسی کنید.',
    'ms': 'Rujukan pendidikan piawaian dan kod. Sahkan keperluan rasmi.',
  }, 'Educational reference for standards and codes. Verify latest official requirements.');

  static String _safeWorkPoint(BuildContext context) => _pick(context, {
    'en':'Isolate, lock out, and verify zero energy before work.', 'ur':'کام سے پہلے supply isolate کریں، lock out کریں اور zero energy verify کریں۔', 'hi':'काम से पहले supply अलग करें, lock out करें और zero energy सत्यापित करें।', 'ar':'افصل التغذية واستخدم القفل وتحقق من عدم وجود طاقة.', 'es':'Aísle, bloquee y verifique energía cero.', 'pt':'Isole, bloqueie e confirme energia zero antes do trabalho.', 'fr':'Isolez, verrouillez et vérifiez l’absence d’énergie avant travail.', 'de':'Freischalten, verriegeln und Spannungsfreiheit prüfen.', 'ru':'Отключите, заблокируйте и проверьте отсутствие энергии.', 'zh':'作业前请隔离、上锁并确认无电。', 'tr':'Çalışmadan önce izole edin, kilitleyin ve enerjisizliği doğrulayın.', 'id':'Isolasi, kunci, dan pastikan energi nol sebelum bekerja.', 'bn':'কাজের আগে বিচ্ছিন্ন, লক আউট এবং zero energy যাচাই করুন।', 'fa':'قبل از کار، ایزوله و قفل کنید و نبود انرژی را بررسی کنید.', 'ms':'Asingkan, kunci dan sahkan tiada tenaga sebelum kerja.'
  }, 'Isolate, lock out, and verify zero energy before work.');
  static String _verifyPoint(BuildContext context) => _pick(context, {
    'en':'Use PPE, insulated tools, and a correctly rated tester.', 'ur':'PPE، insulated tools اور rated tester استعمال کریں۔', 'hi':'PPE, insulated tools और rated tester उपयोग करें।', 'ar':'استخدم معدات الوقاية والأدوات المعزولة وجهاز اختبار مناسب.', 'es':'Use EPP, herramientas aisladas y comprobador adecuado.', 'pt':'Use EPI, ferramentas isoladas e testador adequado.', 'fr':'Utilisez EPI, outils isolés et testeur adapté.', 'de':'PSA, isolierte Werkzeuge und passenden Prüfer verwenden.', 'ru':'Используйте СИЗ, изолированный инструмент и подходящий тестер.', 'zh':'使用PPE、绝缘工具和合适等级的测试仪。', 'tr':'KKD, yalıtımlı alet ve doğru sınıf test cihazı kullanın.', 'id':'Gunakan APD, alat berisolasi, dan tester berating benar.', 'bn':'PPE, insulated tools এবং rated tester ব্যবহার করুন।', 'fa':'از PPE، ابزار عایق و تستر مناسب استفاده کنید.', 'ms':'Gunakan PPE, alat berpenebat dan penguji berkadar betul.'
  }, 'Use PPE, insulated tools, and a correctly rated tester.');
  static String _codePoint(BuildContext context) => _pick(context, {
    'en':'Check applicable code, utility rules, site conditions, and equipment ratings.', 'ur':'applicable code، utility rules، site conditions اور equipment ratings چیک کریں۔', 'hi':'applicable code, utility rules, site conditions और equipment ratings जांचें।', 'ar':'تحقق من الكود والقواعد المحلية وظروف الموقع وتصنيف المعدات.', 'es':'Revise código, reglas de compañía, sitio y placas del equipo.', 'pt':'Verifique código, regras da concessionária, local e ratings.', 'fr':'Vérifiez code, règles réseau, site et caractéristiques.', 'de':'Normen, Netzbetreiberregeln, Standort und Gerätdaten prüfen.', 'ru':'Проверьте нормы, правила сети, условия объекта и номиналы.', 'zh':'检查适用规范、供电规则、现场条件和设备额定值。', 'tr':'Kod, dağıtım kuralları, saha koşulları ve ekipman değerlerini kontrol edin.', 'id':'Periksa kode, aturan utilitas, kondisi lokasi, dan rating alat.', 'bn':'প্রযোজ্য code, utility rules, site conditions ও equipment ratings চেক করুন।', 'fa':'کد، مقررات برق، شرایط محل و رتبه تجهیزات را بررسی کنید.', 'ms':'Semak kod, peraturan utiliti, keadaan tapak dan rating peralatan.'
  }, 'Check applicable code, utility rules, site conditions, and equipment ratings.');
  static String _mistakePoint(BuildContext context) => _pick(context, {
    'en':'Do not decide by guess, color, or habit only.', 'ur':'صرف اندازے، رنگ یا عادت کی بنیاد پر فیصلہ نہ کریں۔', 'hi':'सिर्फ अनुमान, रंग या आदत से निर्णय न लें।', 'ar':'لا تعتمد على التخمين أو اللون أو العادة فقط.', 'es':'No decida solo por suposición, color o costumbre.', 'pt':'Não decida apenas por palpite, cor ou hábito.', 'fr':'Ne décidez pas seulement par supposition, couleur ou habitude.', 'de':'Nicht nur nach Vermutung, Farbe oder Gewohnheit entscheiden.', 'ru':'Не решайте только по догадке, цвету или привычке.', 'zh':'不要只凭猜测、颜色或习惯判断。', 'tr':'Sadece tahmin, renk veya alışkanlıkla karar vermeyin.', 'id':'Jangan memutuskan hanya dari tebakan, warna, atau kebiasaan.', 'bn':'শুধু অনুমান, রং বা অভ্যাস দিয়ে সিদ্ধান্ত নেবেন না।', 'fa':'فقط با حدس، رنگ یا عادت تصمیم نگیرید.', 'ms':'Jangan buat keputusan hanya dengan tekaan, warna atau kebiasaan.'
  }, 'Do not decide by guess, color, or habit only.');
  static String _recordPoint(BuildContext context) => _pick(context, {
    'en':'Keep measurements, calculations, and test results recorded.', 'ur':'measurements، calculations اور test results محفوظ رکھیں۔', 'hi':'measurements, calculations और test results सुरक्षित रखें।', 'ar':'احتفظ بالقياسات والحسابات ونتائج الاختبار.', 'es':'Guarde mediciones, cálculos y resultados.', 'pt':'Registre medições, cálculos e resultados de teste.', 'fr':'Conservez mesures, calculs et résultats de test.', 'de':'Messungen, Berechnungen und Prüfergebnisse dokumentieren.', 'ru':'Записывайте измерения, расчеты и результаты испытаний.', 'zh':'记录测量、计算和测试结果。', 'tr':'Ölçüm, hesap ve test sonuçlarını kaydedin.', 'id':'Catat pengukuran, perhitungan, dan hasil uji.', 'bn':'measurements, calculations এবং test results রেকর্ড রাখুন।', 'fa':'اندازه‌گیری، محاسبات و نتایج تست را ثبت کنید.', 'ms':'Rekod ukuran, pengiraan dan keputusan ujian.'
  }, 'Keep measurements, calculations, and test results recorded.');
  static String _qualifiedPoint(BuildContext context) => _pick(context, {
    'en':'When in doubt, consult a qualified professional.', 'ur':'شک ہو تو qualified professional سے مشورہ کریں۔', 'hi':'संदेह हो तो qualified professional से सलाह लें।', 'ar':'عند الشك استشر مختصاً مؤهلاً.', 'es':'Si hay duda, consulte a un profesional calificado.', 'pt':'Em dúvida, consulte um profissional qualificado.', 'fr':'En cas de doute, consultez un professionnel qualifié.', 'de':'Bei Zweifel qualifizierte Fachkraft konsultieren.', 'ru':'При сомнениях обратитесь к квалифицированному специалисту.', 'zh':'如有疑问，请咨询合格专业人员。', 'tr':'Şüphede kalırsanız yetkili uzmana danışın.', 'id':'Jika ragu, konsultasikan dengan profesional berkualifikasi.', 'bn':'সন্দেহ হলে qualified professional এর পরামর্শ নিন।', 'fa':'در صورت تردید با متخصص واجد شرایط مشورت کنید.', 'ms':'Jika ragu, rujuk profesional berkelayakan.'
  }, 'When in doubt, consult a qualified professional.');

  // Dictionaries used above
  static const Map<String, Map<String, List<String>>> _standardsListTemplates = {
    'en': {'keyPoints':['Use the official code applicable in your country or region.','Verify design with utility, authority, and manufacturer requirements.','Keep calculations, test results, and inspection records.'], 'checklist':['Identify applicable code and local authority.','Check ratings, protection, earthing/grounding, and labels.','Test before energizing and document results.'], 'warnings':['This app is not an official code book.','Do not perform electrical work beyond your qualification.']},
    'ur': {'keyPoints':['اپنے ملک یا علاقے کا official code استعمال کریں۔','design کو utility، authority اور manufacturer requirements سے verify کریں۔','calculations، test results اور inspection records محفوظ رکھیں۔'], 'checklist':['لاگو code اور local authority identify کریں۔','ratings، protection، earthing/grounding اور labels چیک کریں۔','energize کرنے سے پہلے test کریں اور results document کریں۔'], 'warnings':['یہ app official code book نہیں ہے۔','اپنی qualification سے باہر electrical work نہ کریں۔']},
    'hi': {'keyPoints':['अपने देश या क्षेत्र का official code उपयोग करें।','design को utility, authority और manufacturer requirements से verify करें।','calculations, test results और inspection records सुरक्षित रखें।'], 'checklist':['लागू code और local authority पहचानें।','ratings, protection, earthing/grounding और labels जांचें।','energize करने से पहले test करें और results लिखें।'], 'warnings':['यह app official code book नहीं है।','अपनी qualification से बाहर electrical work न करें।']},
    'ar': {'keyPoints':['استخدم الكود الرسمي المطبق في بلدك أو منطقتك.','تحقق من التصميم مع متطلبات شركة الكهرباء والجهة المختصة والشركة المصنعة.','احتفظ بالحسابات ونتائج الاختبار وسجلات التفتيش.'], 'checklist':['حدد الكود والجهة المحلية المطبقة.','تحقق من التصنيفات والحماية والتأريض والملصقات.','اختبر قبل التشغيل ووثق النتائج.'], 'warnings':['هذا التطبيق ليس كتاب كود رسمي.','لا تنفذ أعمالاً كهربائية خارج مؤهلاتك.']},
  };

  static const Map<String, Map<String, String>> _contentLabels = {
    'en': {'overview':'Overview','practical':'Practical Explanation','keyPoints':'Key Points','formulas':'Formulas / Technical Notes','safety':'Safety Notes','mistakes':'Common Mistakes','tips':'Professional Tips','standards':'Standards Reference Note','noFormula':'Use formulas only where applicable.'},
    'ur': {'overview':'جائزہ','practical':'عملی وضاحت','keyPoints':'اہم نکات','formulas':'فارمولے / تکنیکی نوٹس','safety':'حفاظتی نوٹس','mistakes':'عام غلطیاں','tips':'پیشہ ورانہ مشورے','standards':'معیارات ریفرنس نوٹ','noFormula':'اس موضوع میں فارمولا صرف ضرورت کے مطابق استعمال کریں۔'},
    'hi': {'overview':'अवलोकन','practical':'व्यावहारिक व्याख्या','keyPoints':'मुख्य बिंदु','formulas':'सूत्र / तकनीकी नोट','safety':'सुरक्षा नोट','mistakes':'सामान्य गलतियाँ','tips':'पेशेवर सुझाव','standards':'मानक संदर्भ नोट','noFormula':'जहाँ लागू हो वहाँ सूत्र उपयोग करें।'},
    'ar': {'overview':'نظرة عامة','practical':'شرح عملي','keyPoints':'نقاط رئيسية','formulas':'معادلات / ملاحظات فنية','safety':'ملاحظات السلامة','mistakes':'أخطاء شائعة','tips':'نصائح مهنية','standards':'ملاحظة مرجعية للمعايير','noFormula':'استخدم المعادلات عند الحاجة.'},
    'es': {'overview':'Resumen','practical':'Explicación práctica','keyPoints':'Puntos clave','formulas':'Fórmulas / notas técnicas','safety':'Notas de seguridad','mistakes':'Errores comunes','tips':'Consejos profesionales','standards':'Nota de normas','noFormula':'Use fórmulas solo cuando corresponda.'},
    'pt': {'overview':'Visão geral','practical':'Explicação prática','keyPoints':'Pontos-chave','formulas':'Fórmulas / notas técnicas','safety':'Notas de segurança','mistakes':'Erros comuns','tips':'Dicas profissionais','standards':'Nota de normas','noFormula':'Use fórmulas apenas quando aplicável.'},
    'fr': {'overview':'Aperçu','practical':'Explication pratique','keyPoints':'Points clés','formulas':'Formules / notes techniques','safety':'Notes de sécurité','mistakes':'Erreurs courantes','tips':'Conseils professionnels','standards':'Note de normes','noFormula':'Utilisez les formules seulement si applicable.'},
    'de': {'overview':'Überblick','practical':'Praktische Erklärung','keyPoints':'Kernpunkte','formulas':'Formeln / technische Hinweise','safety':'Sicherheitshinweise','mistakes':'Häufige Fehler','tips':'Fachtipps','standards':'Normenhinweis','noFormula':'Formeln nur verwenden, wenn zutreffend.'},
    'ru': {'overview':'Обзор','practical':'Практическое объяснение','keyPoints':'Ключевые пункты','formulas':'Формулы / технические заметки','safety':'Заметки по безопасности','mistakes':'Частые ошибки','tips':'Профессиональные советы','standards':'Заметка по стандартам','noFormula':'Используйте формулы только где применимо.'},
    'zh': {'overview':'概述','practical':'实践说明','keyPoints':'要点','formulas':'公式 / 技术说明','safety':'安全说明','mistakes':'常见错误','tips':'专业提示','standards':'标准参考说明','noFormula':'仅在适用时使用公式。'},
    'tr': {'overview':'Genel bakış','practical':'Pratik açıklama','keyPoints':'Önemli noktalar','formulas':'Formüller / teknik notlar','safety':'Güvenlik notları','mistakes':'Yaygın hatalar','tips':'Profesyonel ipuçları','standards':'Standart notu','noFormula':'Formülleri yalnızca uygunsa kullanın.'},
    'id': {'overview':'Gambaran umum','practical':'Penjelasan praktis','keyPoints':'Poin penting','formulas':'Rumus / catatan teknis','safety':'Catatan keselamatan','mistakes':'Kesalahan umum','tips':'Tips profesional','standards':'Catatan standar','noFormula':'Gunakan rumus hanya jika sesuai.'},
    'bn': {'overview':'সংক্ষিপ্ত বিবরণ','practical':'ব্যবহারিক ব্যাখ্যা','keyPoints':'মূল পয়েন্ট','formulas':'সূত্র / প্রযুক্তিগত নোট','safety':'নিরাপত্তা নোট','mistakes':'সাধারণ ভুল','tips':'পেশাদার টিপস','standards':'স্ট্যান্ডার্ড রেফারেন্স নোট','noFormula':'যেখানে প্রযোজ্য শুধু সেখানে সূত্র ব্যবহার করুন।'},
    'fa': {'overview':'نمای کلی','practical':'توضیح عملی','keyPoints':'نکات کلیدی','formulas':'فرمول‌ها / نکات فنی','safety':'نکات ایمنی','mistakes':'اشتباهات رایج','tips':'نکات حرفه‌ای','standards':'یادداشت استاندارد','noFormula':'فرمول‌ها را فقط در صورت کاربرد استفاده کنید.'},
    'ms': {'overview':'Gambaran keseluruhan','practical':'Penjelasan praktikal','keyPoints':'Perkara penting','formulas':'Formula / nota teknikal','safety':'Nota keselamatan','mistakes':'Kesilapan biasa','tips':'Petua profesional','standards':'Nota piawaian','noFormula':'Gunakan formula hanya apabila sesuai.'},
  };
  static const Map<String, Map<String, String>> _wiringActionTerms = {
    'ur': {'Connect':'کنیکٹ کریں','Install':'انسٹال کریں','Run':'چلائیں','Wire':'وائر کریں','Label':'لیبل کریں','Switch':'سوئچ','Socket':'ساکٹ','Neutral':'نیوٹرل','Live':'لائیو','Earth':'ارتھ'},
    'hi': {'Connect':'कनेक्ट करें','Install':'इंस्टॉल करें','Run':'चलाएँ','Wire':'वायर करें','Label':'लेबल करें','Switch':'स्विच','Socket':'सॉकेट','Neutral':'न्यूट्रल','Live':'लाइव','Earth':'अर्थ'},
    'ar': {'Connect':'وصّل','Install':'ثبّت','Run':'مرّر','Wire':'قم بالتوصيل','Label':'ضع ملصقاً','Switch':'مفتاح','Socket':'مقبس','Neutral':'محايد','Live':'حي','Earth':'أرضي'},
    'es': {'Connect':'Conecte','Install':'Instale','Run':'Tienda','Wire':'Cablee','Label':'Etiquete','Switch':'Interruptor','Socket':'Tomacorriente','Neutral':'Neutro','Live':'Fase','Earth':'Tierra'},
  };

  static const Map<String, Map<String, String>> _quizTerms = {
    'ur': {'What':'کیا','Which':'کون سا','Why':'کیوں','How':'کیسے','correct':'درست','best':'بہترین','Answer':'جواب'},
    'hi': {'What':'क्या','Which':'कौन सा','Why':'क्यों','How':'कैसे','correct':'सही','best':'श्रेष्ठ','Answer':'उत्तर'},
    'ar': {'What':'ما','Which':'أي','Why':'لماذا','How':'كيف','correct':'صحيح','best':'أفضل','Answer':'إجابة'},
    'es': {'What':'Qué','Which':'Cuál','Why':'Por qué','How':'Cómo','correct':'correcto','best':'mejor','Answer':'Respuesta'},
  };

  static Map<String, String> _multi(String en, String ur, String hi, String ar, String es, String pt, String fr, String de, String ru, String zh, String tr, String id, String bn, String fa, String ms) => {
        'en': en, 'ur': ur, 'hi': hi, 'ar': ar, 'es': es, 'pt': pt, 'fr': fr, 'de': de, 'ru': ru, 'zh': zh, 'tr': tr, 'id': id, 'bn': bn, 'fa': fa, 'ms': ms,
      };

  static final Map<String, Map<String, String>> _categoryNames = {
    'basics': _multi('Electrical Basics','الیکٹریکل بنیادیات','विद्युत मूल बातें','أساسيات الكهرباء','Conceptos básicos','Básico elétrico','Bases électriques','Elektrogrundlagen','Основы электрики','电气基础','Elektrik Temelleri','Dasar Listrik','বৈদ্যুতিক বেসিক','مبانی برق','Asas Elektrik'),
    'components': _multi('Components','کمپوننٹس','घटक','المكونات','Componentes','Componentes','Composants','Komponenten','Компоненты','元件','Bileşenler','Komponen','কম্পোনেন্ট','قطعات','Komponen'),
    'circuits': _multi('Circuits & Laws','سرکٹس اور قوانین','सर्किट और नियम','الدوائر والقوانين','Circuitos y leyes','Circuitos e leis','Circuits et lois','Schaltungen & Gesetze','Цепи и законы','电路与定律','Devreler ve Yasalar','Rangkaian & Hukum','সার্কিট ও আইন','مدارها و قوانین','Litar & Hukum'),
    'calculations': _multi('Calculations','کیلکولیشنز','गणनाएँ','الحسابات','Cálculos','Cálculos','Calculs','Berechnungen','Расчеты','计算','Hesaplamalar','Perhitungan','হিসাব','محاسبات','Pengiraan'),
    'safety': _multi('Safety & Codes','حفاظت اور کوڈز','सुरक्षा और कोड','السلامة والأكواد','Seguridad y códigos','Segurança e códigos','Sécurité et codes','Sicherheit & Normen','Безопасность и нормы','安全与规范','Güvenlik ve Kodlar','Keselamatan & Kod','নিরাপত্তা ও কোড','ایمنی و کدها','Keselamatan & Kod'),
    'motors': _multi('Motors & Drives','موٹرز اور ڈرائیوز','मोटर और ड्राइव','المحركات والدرايفات','Motores y variadores','Motores e drives','Moteurs et variateurs','Motoren & Antriebe','Двигатели и приводы','电机与驱动','Motorlar ve Sürücüler','Motor & Pemacu','মোটর ও ড্রাইভ','موتورها و درایوها','Motor & Pemacu'),
    'solar': _multi('Solar & EV','سولر اور EV','सौर और EV','الطاقة الشمسية و EV','Solar y EV','Solar e EV','Solaire et VE','Solar & EV','Солнечная и EV','太阳能与电动车','Güneş ve EV','Surya & EV','সোলার ও EV','خورشیدی و EV','Solar & EV'),
    'renewable': _multi('Solar & EV','سولر اور EV','सौर और EV','الطاقة الشمسية و EV','Solar y EV','Solar e EV','Solaire et VE','Solar & EV','Солнечная и EV','太阳能与电动车','Güneş ve EV','Surya & EV','সোলার ও EV','خورشیدی و EV','Solar & EV'),
    'modern': _multi('Modern Systems','جدید سسٹمز','आधुनिक सिस्टम','الأنظمة الحديثة','Sistemas modernos','Sistemas modernos','Systèmes modernes','Moderne Systeme','Современные системы','现代系统','Modern Sistemler','Sistem Modern','আধুনিক সিস্টেম','سیستم‌های مدرن','Sistem Moden'),
    'standards': _multi('Standards & Codes','معیارات اور کوڈز','मानक और कोड','المعايير والأكواد','Normas y códigos','Normas e códigos','Normes et codes','Normen & Vorschriften','Стандарты и нормы','标准与规范','Standartlar ve Kodlar','Standar & Kode','মানদণ্ড ও কোড','استانداردها و کدها','Piawaian & Kod'),
    'master': _multi('Master Level','ماسٹر لیول','मास्टर स्तर','مستوى متقدم','Nivel maestro','Nível mestre','Niveau maître','Meister-Level','Мастер-уровень','大师级','Usta Seviyesi','Tingkat Master','মাস্টার লেভেল','سطح استاد','Tahap Master'),
    'basic': _multi('Electrical Basics','الیکٹریکل بنیادیات','विद्युत मूल बातें','أساسيات الكهرباء','Conceptos básicos','Básico elétrico','Bases électriques','Elektrogrundlagen','Основы электрики','电气基础','Elektrik Temelleri','Dasar Listrik','বৈদ্যুতিক বেসিক','مبانی برق','Asas Elektrik'),
    'cable': _multi('Cables & Conductors','کیبلز اور کنڈکٹرز','केबल और चालक','الكابلات والموصلات','Cables y conductores','Cabos e condutores','Câbles et conducteurs','Kabel & Leiter','Кабели и проводники','电缆和导体','Kablolar ve İletkenler','Kabel & Konduktor','কেবল ও কন্ডাক্টর','کابل‌ها و هادی‌ها','Kabel & Konduktor'),
    'motor': _multi('Motors & Drives','موٹرز اور ڈرائیوز','मोटर और ड्राइव','المحركات والدرايفات','Motores y variadores','Motores e drives','Moteurs et variateurs','Motoren & Antriebe','Двигатели и приводы','电机与驱动','Motorlar ve Sürücüler','Motor & Pemacu','মোটর ও ড্রাইভ','موتورها و درایوها','Motor & Pemacu'),
    'power': _multi('Power Systems','پاور سسٹمز','पावर सिस्टम','أنظمة القدرة','Sistemas de potencia','Sistemas de potência','Systèmes électriques','Energiesysteme','Энергосистемы','电力系统','Güç Sistemleri','Sistem Daya','পাওয়ার সিস্টেম','سیستم‌های قدرت','Sistem Kuasa'),
    'protection': _multi('Protection','پروٹیکشن','सुरक्षा','الحماية','Protección','Proteção','Protection','Schutz','Защита','保护','Koruma','Perlindungan','সুরক্ষা','حفاظت','Perlindungan'),
    'converter': _multi('Converters & Codes','کنورٹرز اور کوڈز','कन्वर्टर और कोड','المحولات والأكواد','Convertidores y códigos','Conversores e códigos','Convertisseurs et codes','Konverter & Codes','Конвертеры и коды','转换器和代码','Dönüştürücüler ve Kodlar','Penukar & Kod','কনভার্টার ও কোড','مبدل‌ها و کدها','Penukar & Kod'),
    'residential': _multi('Residential Wiring','رہائشی وائرنگ','घरेलू वायरिंग','توصيلات سكنية','Cableado residencial','Fiação residencial','Câblage résidentiel','Hausinstallation','Жилая проводка','住宅接线','Konut Kablolama','Pengkabelan Rumah','বাসার ওয়্যারিং','سیم‌کشی مسکونی','Pendawaian Rumah'),
    'distribution': _multi('Distribution Boards','ڈسٹری بیوشن بورڈز','डिस्ट्रिब्यूशन बोर्ड','لوحات التوزيع','Tableros de distribución','Quadros de distribuição','Tableaux de distribution','Verteiler','Щиты распределения','配电箱','Dağıtım Panoları','Panel Distribusi','ডিস্ট্রিবিউশন বোর্ড','تابلو توزیع','Papan Agihan'),
    'generator': _multi('Generator & ATS','جنریٹر اور ATS','जनरेटर और ATS','المولد و ATS','Generador y ATS','Gerador e ATS','Générateur et ATS','Generator & ATS','Генератор и АВР','发电机和ATS','Jeneratör ve ATS','Generator & ATS','জেনারেটর ও ATS','ژنراتور و ATS','Generator & ATS'),
    'smart': _multi('Smart Home','سمارٹ ہوم','स्मार्ट होम','المنزل الذكي','Casa inteligente','Casa inteligente','Maison intelligente','Smart Home','Умный дом','智能家居','Akıllı Ev','Rumah Pintar','স্মার্ট হোম','خانه هوشمند','Rumah Pintar'),
    'iec': _multi('IEC / International','IEC / انٹرنیشنل','IEC / अंतरराष्ट्रीय','IEC / دولي','IEC / Internacional','IEC / Internacional','IEC / International','IEC / International','IEC / Международный','IEC / 国际','IEC / Uluslararası','IEC / Internasional','IEC / আন্তর্জাতিক','IEC / بین‌المللی','IEC / Antarabangsa'),
    'nec': _multi('NEC / NFPA 70','NEC / NFPA 70','NEC / NFPA 70','NEC / NFPA 70','NEC / NFPA 70','NEC / NFPA 70','NEC / NFPA 70','NEC / NFPA 70','NEC / NFPA 70','NEC / NFPA 70','NEC / NFPA 70','NEC / NFPA 70','NEC / NFPA 70','NEC / NFPA 70','NEC / NFPA 70'),
    'bs7671': _multi('BS 7671 / UK','BS 7671 / UK','BS 7671 / UK','BS 7671 / UK','BS 7671 / UK','BS 7671 / UK','BS 7671 / UK','BS 7671 / UK','BS 7671 / UK','BS 7671 / UK','BS 7671 / UK','BS 7671 / UK','BS 7671 / UK','BS 7671 / UK','BS 7671 / UK'),
    'pakistan': _multi('Pakistan / PEC','پاکستان / PEC','पाकिस्तान / PEC','باكستان / PEC','Pakistán / PEC','Paquistão / PEC','Pakistan / PEC','Pakistan / PEC','Пакистан / PEC','巴基斯坦 / PEC','Pakistan / PEC','Pakistan / PEC','পাকিস্তান / PEC','پاکستان / PEC','Pakistan / PEC'),
    'solar_ev': _multi('Solar, EV & Grid','سولر، EV اور گرڈ','सौर, EV और ग्रिड','الطاقة الشمسية و EV والشبكة','Solar, EV y red','Solar, EV e rede','Solaire, VE et réseau','Solar, EV & Netz','Солнечная, EV и сеть','太阳能、电动车和电网','Güneş, EV ve Şebeke','Surya, EV & Grid','সোলার, EV ও গ্রিড','خورشیدی، EV و شبکه','Solar, EV & Grid'),
    'earthing': _multi('Earthing & Protection','ارتھنگ اور پروٹیکشن','अर्थिंग और सुरक्षा','التأريض والحماية','Puesta a tierra y protección','Aterramento e proteção','Mise à la terre et protection','Erdung & Schutz','Заземление и защита','接地与保护','Topraklama ve Koruma','Pembumian & Perlindungan','আর্থিং ও সুরক্ষা','ارتینگ و حفاظت','Pembumian & Perlindungan'),
    'global_safety': _multi('Global Safety Principles','گلوبل سیفٹی اصول','वैश्विक सुरक्षा सिद्धांत','مبادئ السلامة العالمية','Principios globales de seguridad','Princípios globais de segurança','Principes mondiaux de sécurité','Globale Sicherheitsprinzipien','Глобальные принципы безопасности','全球安全原则','Küresel Güvenlik İlkeleri','Prinsip Keselamatan Global','গ্লোবাল নিরাপত্তা নীতি','اصول ایمنی جهانی','Prinsip Keselamatan Global'),
  };

  static const Map<String, Map<String, String>> _difficulty = {
    'beginner': {
      'ur':'ابتدائی','hi':'शुरुआती','ar':'مبتدئ','es':'Principiante','pt':'Iniciante','fr':'Débutant','de':'Anfänger','ru':'Новичок','zh':'初级','tr':'Başlangıç','id':'Pemula','bn':'শুরুর','fa':'مقدماتی','ms':'Pemula',
      'it':'Principiante','ja':'初級','ko':'초급','vi':'Cơ bản','th':'ระดับต้น','pl':'Początkujący','nl':'Beginner','uk':'Початківець','ro':'Începător','sv':'Nybörjare','hu':'Kezdő','cs':'Začátečník','el':'Αρχάριος','bg':'Начинаещ','da':'Begynder','fi':'Aloittelija','no':'Nybegynner','sk':'Začiatočník','hr':'Početnik','sr':'Почетник','ta':'தொடக்க','te':'ప్రారంభ','kn':'ಆರಂಭಿಕ','mr':'सुरुवाती','gu':'શરૂઆતી','pa':'ਸ਼ੁਰੂਆਤੀ','sw':'Mwanzilishi','tl':'Baguhan','he':'מתחיל','az':'Başlanğıc','uz':'Boshlangʻich','my':'အခြေခံ','km':'ដំបូង','si':'මූලික','am':'ጀማሪ'
    },
    'journeyman': {
      'ur':'درمیانی','hi':'मध्यम','ar':'متوسط','es':'Intermedio','pt':'Intermediário','fr':'Intermédiaire','de':'Fortgeschritten','ru':'Средний','zh':'中级','tr':'Orta','id':'Menengah','bn':'মাঝারি','fa':'متوسط','ms':'Pertengahan',
      'it':'Intermedio','ja':'中級','ko':'중급','vi':'Trung cấp','th':'ระดับกลาง','pl':'Średniozaawansowany','nl':'Gevorderd','uk':'Середній','ro':'Intermediar','sv':'Medel','hu':'Középhaladó','cs':'Pokročilý','el':'Μεσαίο','bg':'Средно','da':'Øvet','fi':'Keskitaso','no':'Viderekommen','sk':'Stredne pokročilý','hr':'Srednje','sr':'Средњи','ta':'இடைநிலை','te':'మధ్యస్థ','kn':'ಮಧ್ಯಮ','mr':'मध्यम','gu':'મધ્યમ','pa':'ਮੱਧਮ','sw':'Kati','tl':'Katamtaman','he':'בינוני','az':'Orta','uz':'Oʻrta','my':'အလယ်အလတ်','km':'មធ្យម','si':'මධ්‍යම','am':'መካከለኛ'
    },
    'master': {
      'ur':'ماہر','hi':'मास्टर','ar':'متقدم','es':'Avanzado','pt':'Avançado','fr':'Avancé','de':'Meister','ru':'Мастер','zh':'高级','tr':'Usta','id':'Master','bn':'মাস্টার','fa':'پیشرفته','ms':'Master',
      'it':'Avanzato','ja':'上級','ko':'고급','vi':'Nâng cao','th':'ระดับสูง','pl':'Zaawansowany','nl':'Expert','uk':'Експерт','ro':'Avansat','sv':'Avancerad','hu':'Haladó','cs':'Expert','el':'Προχωρημένο','bg':'Напреднал','da':'Avanceret','fi':'Edistynyt','no':'Avansert','sk':'Expert','hr':'Napredno','sr':'Напредни','ta':'மேம்பட்ட','te':'ఉన్నత','kn':'ಉನ್ನತ','mr':'प्रगत','gu':'અદ્યતન','pa':'ਉੱਨਤ','sw':'Juu','tl':'Advanced','he':'מתקדם','az':'Qabaqcıl','uz':'Yuqori','my':'အဆင့်မြင့်','km':'កម្រិតខ្ពស់','si':'උසස්','am':'ከፍተኛ'
    },
    'easy': {
      'ur':'آسان','hi':'आसान','ar':'سهل','es':'Fácil','pt':'Fácil','fr':'Facile','de':'Einfach','ru':'Легко','zh':'简单','tr':'Kolay','id':'Mudah','bn':'সহজ','fa':'آسان','ms':'Mudah',
      'it':'Facile','ja':'簡単','ko':'쉬움','vi':'Dễ','th':'ง่าย','pl':'Łatwy','nl':'Makkelijk','uk':'Легко','ro':'Ușor','sv':'Lätt','hu':'Könnyű','cs':'Snadné','el':'Εύκολο','bg':'Лесно','da':'Nem','fi':'Helppo','no':'Lett','sk':'Ľahké','hr':'Lako','sr':'Лако','ta':'எளிது','te':'సులభం','kn':'ಸುಲಭ','mr':'सोपे','gu':'સરળ','pa':'ਆਸਾਨ','sw':'Rahisi','tl':'Madali','he':'קל','az':'Asan','uz':'Oson','my':'လွယ်','km':'ងាយ','si':'පහසු','am':'ቀላል'
    },
    'medium': {
      'ur':'درمیانہ','hi':'मध्यम','ar':'متوسط','es':'Medio','pt':'Médio','fr':'Moyen','de':'Mittel','ru':'Средне','zh':'中等','tr':'Orta','id':'Sedang','bn':'মাঝারি','fa':'متوسط','ms':'Sederhana',
      'it':'Medio','ja':'普通','ko':'보통','vi':'Trung bình','th':'ปานกลาง','pl':'Średni','nl':'Gemiddeld','uk':'Середньо','ro':'Mediu','sv':'Medel','hu':'Közepes','cs':'Střední','el':'Μέτριο','bg':'Средно','da':'Mellem','fi':'Keskitaso','no':'Middels','sk':'Stredné','hr':'Srednje','sr':'Средње','ta':'நடுத்தர','te':'మధ్యస్థ','kn':'ಮಧ್ಯಮ','mr':'मध्यम','gu':'મધ્યમ','pa':'ਦਰਮਿਆਨਾ','sw':'Wastani','tl':'Katamtaman','he':'בינוני','az':'Orta','uz':'Oʻrta','my':'သင့်တင့်','km':'មធ្យម','si':'මධ්‍යස්ථ','am':'መካከለኛ'
    },
    'hard': {
      'ur':'مشکل','hi':'कठिन','ar':'صعب','es':'Difícil','pt':'Difícil','fr':'Difficile','de':'Schwer','ru':'Сложно','zh':'困难','tr':'Zor','id':'Sulit','bn':'কঠিন','fa':'سخت','ms':'Sukar',
      'it':'Difficile','ja':'難しい','ko':'어려움','vi':'Khó','th':'ยาก','pl':'Trudny','nl':'Moeilijk','uk':'Важко','ro':'Greu','sv':'Svår','hu':'Nehéz','cs':'Těžké','el':'Δύσκολο','bg':'Трудно','da':'Svær','fi':'Vaikea','no':'Vanskelig','sk':'Ťažké','hr':'Teško','sr':'Тешко','ta':'கடினம்','te':'కష్టం','kn':'ಕಷ್ಟ','mr':'कठीण','gu':'મુશ્કેલ','pa':'ਮੁਸ਼ਕਲ','sw':'Ngumu','tl':'Mahirap','he':'קשה','az':'Çətin','uz':'Qiyin','my':'ခက်','km':'ពិបាក','si':'අපහසු','am':'ከባድ'
    },
  };

  static const Map<String, Map<String, String>> _technicalTerms = {
    'ur': {'Electrical':'الیکٹریکل','Electricity':'بجلی','Basics':'بنیادیات','What is':'کیا ہے','Explained':'وضاحت','Law':'قانون','Voltage':'وولٹیج','Current':'کرنٹ','Resistance':'مزاحمت','Power':'پاور','Energy':'انرجی','Cable':'کیبل','Cables':'کیبلز','Conductor':'کنڈکٹر','Conductors':'کنڈکٹرز','Motor':'موٹر','Transformer':'ٹرانسفارمر','Breaker':'بریکر','Battery':'بیٹری','Solar':'سولر','Panel':'پینل','Earth':'ارتھ','Ground':'گراؤنڈ','Fault':'فالٹ','Generator':'جنریٹر','Inverter':'انورٹر','Load':'لوڈ','Phase':'فیز','Frequency':'فریکوئنسی','Circuit':'سرکٹ','Circuits':'سرکٹس','Wiring':'وائرنگ','Switch':'سوئچ','Socket':'ساکٹ','Lighting':'لائٹنگ','Protection':'پروٹیکشن','Safety':'حفاظت','Calculation':'کیلکولیشن','Calculator':'کیلکولیٹر','Sizing':'سائزنگ','Drop':'ڈراپ','Ohm':'اوہم','Series':'سیریز','Parallel':'پیرالل','Single':'سنگل','Three':'تھری'},
    'hi': {'Electrical':'विद्युत','Electricity':'बिजली','Basics':'मूल बातें','What is':'क्या है','Explained':'व्याख्या','Law':'नियम','Voltage':'वोल्टेज','Current':'करंट','Resistance':'प्रतिरोध','Power':'पावर','Energy':'ऊर्जा','Cable':'केबल','Cables':'केबल','Conductor':'चालक','Conductors':'चालक','Motor':'मोटर','Transformer':'ट्रांसफॉर्मर','Breaker':'ब्रेकर','Battery':'बैटरी','Solar':'सौर','Panel':'पैनल','Earth':'अर्थ','Ground':'ग्राउंड','Fault':'फॉल्ट','Generator':'जनरेटर','Inverter':'इन्वर्टर','Load':'लोड','Phase':'फेज','Frequency':'फ्रीक्वेंसी','Circuit':'सर्किट','Circuits':'सर्किट','Wiring':'वायरिंग','Switch':'स्विच','Socket':'सॉकेट','Lighting':'लाइटिंग','Protection':'सुरक्षा','Safety':'सुरक्षा','Calculation':'गणना','Calculator':'कैलकुलेटर','Sizing':'साइजिंग','Drop':'ड्रॉप','Ohm':'ओम','Series':'सीरीज','Parallel':'पैरेलल','Single':'सिंगल','Three':'तीन'},
    'ar': {'Electrical':'كهربائي','Electricity':'الكهرباء','Basics':'الأساسيات','What is':'ما هو','Explained':'شرح','Law':'قانون','Voltage':'الجهد','Current':'التيار','Resistance':'المقاومة','Power':'القدرة','Energy':'الطاقة','Cable':'الكابل','Cables':'الكابلات','Conductor':'الموصل','Conductors':'الموصلات','Motor':'المحرك','Transformer':'المحول','Breaker':'القاطع','Battery':'البطارية','Solar':'شمسي','Panel':'لوحة','Earth':'أرضي','Ground':'تأريض','Fault':'عطل','Generator':'مولد','Inverter':'عاكس','Load':'حمل','Phase':'طور','Frequency':'تردد','Circuit':'دائرة','Circuits':'دوائر','Wiring':'توصيلات','Switch':'مفتاح','Socket':'مقبس','Lighting':'إنارة','Protection':'حماية','Safety':'سلامة','Calculation':'حساب','Calculator':'حاسبة','Sizing':'تحديد الحجم','Drop':'هبوط','Ohm':'أوم','Series':'توالي','Parallel':'توازي','Single':'أحادي','Three':'ثلاثة'},
    'es': {'Electrical':'Eléctrico','Electricity':'Electricidad','Basics':'Conceptos básicos','What is':'Qué es','Explained':'Explicado','Law':'Ley','Voltage':'Voltaje','Current':'Corriente','Resistance':'Resistencia','Power':'Potencia','Energy':'Energía','Cable':'Cable','Cables':'Cables','Conductor':'Conductor','Conductors':'Conductores','Motor':'Motor','Transformer':'Transformador','Breaker':'Interruptor','Battery':'Batería','Solar':'Solar','Panel':'Panel','Earth':'Tierra','Ground':'Tierra','Fault':'Falla','Generator':'Generador','Inverter':'Inversor','Load':'Carga','Phase':'Fase','Frequency':'Frecuencia','Circuit':'Circuito','Circuits':'Circuitos','Wiring':'Cableado','Switch':'Interruptor','Socket':'Tomacorriente','Lighting':'Iluminación','Protection':'Protección','Safety':'Seguridad','Calculation':'Cálculo','Calculator':'Calculadora','Sizing':'Dimensionamiento','Drop':'Caída','Ohm':'Ohm','Series':'Serie','Parallel':'Paralelo','Single':'Monofásico','Three':'Tres'},
    'pt': {'Electrical':'Elétrico','Electricity':'Eletricidade','Basics':'Básico','What is':'O que é','Explained':'Explicado','Law':'Lei','Voltage':'Tensão','Current':'Corrente','Resistance':'Resistência','Power':'Potência','Energy':'Energia','Cable':'Cabo','Cables':'Cabos','Conductor':'Condutor','Conductors':'Condutores','Motor':'Motor','Transformer':'Transformador','Breaker':'Disjuntor','Battery':'Bateria','Solar':'Solar','Panel':'Painel','Earth':'Terra','Ground':'Aterramento','Fault':'Falha','Generator':'Gerador','Inverter':'Inversor','Load':'Carga','Phase':'Fase','Frequency':'Frequência','Circuit':'Circuito','Circuits':'Circuitos','Wiring':'Fiação','Switch':'Interruptor','Socket':'Tomada','Lighting':'Iluminação','Protection':'Proteção','Safety':'Segurança','Calculation':'Cálculo','Calculator':'Calculadora','Sizing':'Dimensionamento','Drop':'Queda','Ohm':'Ohm','Series':'Série','Parallel':'Paralelo','Single':'Monofásico','Three':'Três'},
    'fr': {'Electrical':'Électrique','Electricity':'Électricité','Basics':'Bases','What is':'Qu’est-ce que','Explained':'Expliqué','Law':'Loi','Voltage':'Tension','Current':'Courant','Resistance':'Résistance','Power':'Puissance','Energy':'Énergie','Cable':'Câble','Cables':'Câbles','Conductor':'Conducteur','Conductors':'Conducteurs','Motor':'Moteur','Transformer':'Transformateur','Breaker':'Disjoncteur','Battery':'Batterie','Solar':'Solaire','Panel':'Panneau','Earth':'Terre','Ground':'Mise à la terre','Fault':'Défaut','Generator':'Générateur','Inverter':'Onduleur','Load':'Charge','Phase':'Phase','Frequency':'Fréquence','Circuit':'Circuit','Circuits':'Circuits','Wiring':'Câblage','Switch':'Interrupteur','Socket':'Prise','Lighting':'Éclairage','Protection':'Protection','Safety':'Sécurité','Calculation':'Calcul','Calculator':'Calculateur','Sizing':'Dimensionnement','Drop':'Chute','Ohm':'Ohm','Series':'Série','Parallel':'Parallèle','Single':'Monophasé','Three':'Trois'},
    'de': {'Electrical':'Elektrisch','Electricity':'Elektrizität','Basics':'Grundlagen','What is':'Was ist','Explained':'Erklärt','Law':'Gesetz','Voltage':'Spannung','Current':'Strom','Resistance':'Widerstand','Power':'Leistung','Energy':'Energie','Cable':'Kabel','Cables':'Kabel','Conductor':'Leiter','Conductors':'Leiter','Motor':'Motor','Transformer':'Transformator','Breaker':'Schalter','Battery':'Batterie','Solar':'Solar','Panel':'Panel','Earth':'Erde','Ground':'Erdung','Fault':'Fehler','Generator':'Generator','Inverter':'Wechselrichter','Load':'Last','Phase':'Phase','Frequency':'Frequenz','Circuit':'Stromkreis','Circuits':'Stromkreise','Wiring':'Verdrahtung','Switch':'Schalter','Socket':'Steckdose','Lighting':'Beleuchtung','Protection':'Schutz','Safety':'Sicherheit','Calculation':'Berechnung','Calculator':'Rechner','Sizing':'Dimensionierung','Drop':'Abfall','Ohm':'Ohm','Series':'Reihe','Parallel':'Parallel','Single':'Einphasig','Three':'Drei'},
    'ru': {'Electrical':'Электрический','Electricity':'Электричество','Basics':'Основы','What is':'Что такое','Explained':'Объяснение','Law':'Закон','Voltage':'Напряжение','Current':'Ток','Resistance':'Сопротивление','Power':'Мощность','Energy':'Энергия','Cable':'Кабель','Cables':'Кабели','Conductor':'Проводник','Conductors':'Проводники','Motor':'Двигатель','Transformer':'Трансформатор','Breaker':'Автомат','Battery':'Батарея','Solar':'Солнечный','Panel':'Панель','Earth':'Земля','Ground':'Заземление','Fault':'Неисправность','Generator':'Генератор','Inverter':'Инвертор','Load':'Нагрузка','Phase':'Фаза','Frequency':'Частота','Circuit':'Цепь','Circuits':'Цепи','Wiring':'Проводка','Switch':'Выключатель','Socket':'Розетка','Lighting':'Освещение','Protection':'Защита','Safety':'Безопасность','Calculation':'Расчет','Calculator':'Калькулятор','Sizing':'Подбор','Drop':'Падение','Ohm':'Ом','Series':'Последовательный','Parallel':'Параллельный','Single':'Одна','Three':'Три'},
    'zh': {'Electrical':'电气','Electricity':'电','Basics':'基础','What is':'什么是','Explained':'说明','Law':'定律','Voltage':'电压','Current':'电流','Resistance':'电阻','Power':'功率','Energy':'能量','Cable':'电缆','Cables':'电缆','Conductor':'导体','Conductors':'导体','Motor':'电机','Transformer':'变压器','Breaker':'断路器','Battery':'电池','Solar':'太阳能','Panel':'面板','Earth':'接地','Ground':'接地','Fault':'故障','Generator':'发电机','Inverter':'逆变器','Load':'负载','Phase':'相','Frequency':'频率','Circuit':'电路','Circuits':'电路','Wiring':'接线','Switch':'开关','Socket':'插座','Lighting':'照明','Protection':'保护','Safety':'安全','Calculation':'计算','Calculator':'计算器','Sizing':'选型','Drop':'压降','Ohm':'欧姆','Series':'串联','Parallel':'并联','Single':'单','Three':'三'},
    'tr': {'Electrical':'Elektrik','Electricity':'Elektrik','Basics':'Temeller','What is':'Nedir','Explained':'Açıklama','Law':'Yasa','Voltage':'Gerilim','Current':'Akım','Resistance':'Direnç','Power':'Güç','Energy':'Enerji','Cable':'Kablo','Cables':'Kablolar','Conductor':'İletken','Conductors':'İletkenler','Motor':'Motor','Transformer':'Transformatör','Breaker':'Kesici','Battery':'Batarya','Solar':'Güneş','Panel':'Panel','Earth':'Toprak','Ground':'Topraklama','Fault':'Arıza','Generator':'Jeneratör','Inverter':'İnverter','Load':'Yük','Phase':'Faz','Frequency':'Frekans','Circuit':'Devre','Circuits':'Devreler','Wiring':'Kablolama','Switch':'Anahtar','Socket':'Priz','Lighting':'Aydınlatma','Protection':'Koruma','Safety':'Güvenlik','Calculation':'Hesap','Calculator':'Hesaplayıcı','Sizing':'Boyutlandırma','Drop':'Düşüm','Ohm':'Ohm','Series':'Seri','Parallel':'Paralel','Single':'Tek','Three':'Üç'},
    'id': {'Electrical':'Listrik','Electricity':'Listrik','Basics':'Dasar','What is':'Apa itu','Explained':'Dijelaskan','Law':'Hukum','Voltage':'Tegangan','Current':'Arus','Resistance':'Resistansi','Power':'Daya','Energy':'Energi','Cable':'Kabel','Cables':'Kabel','Conductor':'Konduktor','Conductors':'Konduktor','Motor':'Motor','Transformer':'Transformator','Breaker':'Pemutus','Battery':'Baterai','Solar':'Surya','Panel':'Panel','Earth':'Arde','Ground':'Grounding','Fault':'Gangguan','Generator':'Generator','Inverter':'Inverter','Load':'Beban','Phase':'Fase','Frequency':'Frekuensi','Circuit':'Rangkaian','Circuits':'Rangkaian','Wiring':'Pengkabelan','Switch':'Sakelar','Socket':'Stopkontak','Lighting':'Penerangan','Protection':'Perlindungan','Safety':'Keselamatan','Calculation':'Perhitungan','Calculator':'Kalkulator','Sizing':'Ukuran','Drop':'Jatuh','Ohm':'Ohm','Series':'Seri','Parallel':'Paralel','Single':'Tunggal','Three':'Tiga'},
    'bn': {'Electrical':'বৈদ্যুতিক','Electricity':'বিদ্যুৎ','Basics':'বেসিক','What is':'কি','Explained':'ব্যাখ্যা','Law':'আইন','Voltage':'ভোল্টেজ','Current':'কারেন্ট','Resistance':'রেজিস্ট্যান্স','Power':'পাওয়ার','Energy':'এনার্জি','Cable':'কেবল','Cables':'কেবল','Conductor':'কন্ডাক্টর','Conductors':'কন্ডাক্টর','Motor':'মোটর','Transformer':'ট্রান্সফর্মার','Breaker':'ব্রেকার','Battery':'ব্যাটারি','Solar':'সোলার','Panel':'প্যানেল','Earth':'আর্থ','Ground':'গ্রাউন্ড','Fault':'ফল্ট','Generator':'জেনারেটর','Inverter':'ইনভার্টার','Load':'লোড','Phase':'ফেজ','Frequency':'ফ্রিকোয়েন্সি','Circuit':'সার্কিট','Circuits':'সার্কিট','Wiring':'ওয়্যারিং','Switch':'সুইচ','Socket':'সকেট','Lighting':'লাইটিং','Protection':'সুরক্ষা','Safety':'নিরাপত্তা','Calculation':'হিসাব','Calculator':'ক্যালকুলেটর','Sizing':'সাইজিং','Drop':'ড্রপ','Ohm':'ওহম','Series':'সিরিজ','Parallel':'প্যারালাল','Single':'সিঙ্গেল','Three':'তিন'},
    'fa': {'Electrical':'برقی','Electricity':'برق','Basics':'مبانی','What is':'چیست','Explained':'توضیح','Law':'قانون','Voltage':'ولتاژ','Current':'جریان','Resistance':'مقاومت','Power':'توان','Energy':'انرژی','Cable':'کابل','Cables':'کابل‌ها','Conductor':'هادی','Conductors':'هادی‌ها','Motor':'موتور','Transformer':'ترانسفورمر','Breaker':'بریکر','Battery':'باتری','Solar':'خورشیدی','Panel':'پنل','Earth':'ارت','Ground':'زمین','Fault':'خطا','Generator':'ژنراتور','Inverter':'اینورتر','Load':'بار','Phase':'فاز','Frequency':'فرکانس','Circuit':'مدار','Circuits':'مدارها','Wiring':'سیم‌کشی','Switch':'کلید','Socket':'پریز','Lighting':'روشنایی','Protection':'حفاظت','Safety':'ایمنی','Calculation':'محاسبه','Calculator':'ماشین‌حساب','Sizing':'سایزبندی','Drop':'افت','Ohm':'اهم','Series':'سری','Parallel':'موازی','Single':'تک','Three':'سه'},
    'ms': {'Electrical':'Elektrik','Electricity':'Elektrik','Basics':'Asas','What is':'Apa itu','Explained':'Diterangkan','Law':'Hukum','Voltage':'Voltan','Current':'Arus','Resistance':'Rintangan','Power':'Kuasa','Energy':'Tenaga','Cable':'Kabel','Cables':'Kabel','Conductor':'Konduktor','Conductors':'Konduktor','Motor':'Motor','Transformer':'Transformer','Breaker':'Pemutus','Battery':'Bateri','Solar':'Solar','Panel':'Panel','Earth':'Bumi','Ground':'Pembumian','Fault':'Kerosakan','Generator':'Generator','Inverter':'Penyongsang','Load':'Beban','Phase':'Fasa','Frequency':'Frekuensi','Circuit':'Litar','Circuits':'Litar','Wiring':'Pendawaian','Switch':'Suis','Socket':'Soket','Lighting':'Pencahayaan','Protection':'Perlindungan','Safety':'Keselamatan','Calculation':'Pengiraan','Calculator':'Kalkulator','Sizing':'Saiz','Drop':'Jatuhan','Ohm':'Ohm','Series':'Siri','Parallel':'Selari','Single':'Tunggal','Three':'Tiga'},
  };}
