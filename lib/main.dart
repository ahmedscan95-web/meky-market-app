import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MekyMarketApp());
}

class MekyMarketApp extends StatelessWidget {
  const MekyMarketApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'ماركت ميكي',
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar', 'EG'),
        supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE65100)),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFE65100),
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
        ),
        home: const SplashScreen(),
      );
}
