# ماركت ميكي - تطبيق سوبر ماركت متكامل

## البدء السريع

### المتطلبات
- Flutter 3.0+
- Android SDK 21+
- Gradle 7.0+
- Java JDK 11+

### التثبيت والتشغيل

```bash
# 1. تحديث الحزم
flutter clean
flutter pub get

# 2. تشغيل التطبيق (في الوضع debug)
flutter run

# 3. بناء APK للإطلاق
flutter build apk --release

# سيظهر الملف النهائي في:
# build/app/outputs/flutter-apk/app-release.apk
```

### بيانات Firebase
- **Project ID**: meky-market
- **Package Name**: com.meky.market
- **API Key**: AIzaSyA-DTZNR2xgFVzpOJ26n-fUw84pTj45pMY
- **Storage Bucket**: meky-market.firebasestorage.app

### بيانات تسجيل الدخول للاختبار
- **Admin Email**: admin@meky.com
- **Admin Password**: Admin@123
- **Customer Test**: customer@meky.com / Customer@123

### الميزات المضافة
✅ Firebase Authentication
✅ Firestore Database
✅ إدارة المنتجات والأقسام
✅ إدارة المتاجر
✅ نظام الطلبات
✅ لوحة تحكم المالك
✅ لوحة الموظف
✅ لوحة العميل
✅ دعم اللغة العربية

### الملفات المهمة
- `lib/firebase_options.dart` - إعدادات Firebase
- `android/app/google-services.json` - تكوين Google Services
- `pubspec.yaml` - جميع التبعيات
- `lib/main.dart` - نقطة الدخول الرئيسية

### استكشاف الأخطاء

إذا حدث خطأ في البناء:
```bash
flutter pub cache clean
flutter clean
flutter pub get
flutter run -v
```

للمزيد من المساعدة، راجع قسم Issues في GitHub.
