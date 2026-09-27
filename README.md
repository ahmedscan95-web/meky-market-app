# ماركت ميكي

تطبيق Flutter عربي لإدارة المنتجات والمتاجر والطلبات باستخدام Firebase.

## التشغيل

1. ثبّت Flutter وFirebase CLI وFlutterFire CLI.
2. أنشئ مشروع Firebase باسم مناسب وفعّل Email/Password Authentication وFirestore.
3. من مجلد المشروع نفّذ:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
flutter pub get
flutter run
```

سيقوم `flutterfire configure` بإنشاء `lib/firebase_options.dart`. بعد ذلك عدّل `lib/main.dart` لاستخدام `DefaultFirebaseOptions.currentPlatform` إذا كان مشروعك يحتاج تهيئة صريحة.

## ملاحظات أمنية مهمة

- لا تستخدم اسم المستخدم وكلمة المرور الثابتين `meky/ahmed` داخل التطبيق؛ أي قيمة داخل تطبيق الهاتف يمكن استخراجها.
- قواعد Firestore الحالية هي نقطة بداية فقط. أنشئ Custom Claims للمالك والموظفين، ثم قيّد عمليات الكتابة حسب الدور من الخادم.
- لا ترفع مفاتيح خاصة أو بيانات Google Sheets أو كلمات مرور إلى GitHub.
