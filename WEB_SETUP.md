# تشغيل ماركت ميكي على Android وWeb

المشروع مبني بـ Flutter، لذلك يمكن تشغيل نفس الكود كتطبيق Android وموقع ويب.

## إعداد Firebase للويب

ملف `lib/firebase_options.dart` الحالي يحتوي إعداد Android فقط. من داخل Codespaces أو جهازك نفّذ:

```bash
flutterfire configure --project=meky-market --platforms=android,web
```

اختر Web وAndroid عند ظهور الاختيارات. سيعيد الأمر إنشاء `lib/firebase_options.dart` بإعدادات المنصتين.

## تشغيل الموقع محليًا

```bash
flutter config --enable-web
flutter pub get
flutter run -d chrome
```

أو تشغيل خادم ويب:

```bash
flutter build web --release
cd build/web
python3 -m http.server 8080
```

## نشر الموقع

يمكن نشر مجلد `build/web` على Firebase Hosting أو GitHub Pages أو أي استضافة ثابتة. عند استخدام Firebase Hosting:

```bash
firebase init hosting
flutter build web --release
firebase deploy --only hosting
```

## ملاحظات

- الواجهات تستخدم `ConstrainedBox` وFlutter responsive layout لتعمل على الهاتف والشاشات الكبيرة.
- يجب تفعيل Web Authentication وFirestore من Firebase Console.
- لا تعتمد على البريد الإلكتروني لتحديد الصلاحيات؛ الدور يُقرأ من `users/{uid}.role`.
- أنشئ مستخدمي الإدارة والموظفين من لوحة آمنة أو Cloud Function، ولا تسمح للعميل بتغيير حقل `role`.
