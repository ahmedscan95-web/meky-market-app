import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'customer/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => FirebaseAuth.instance.currentUser == null
              ? const LoginScreen()
              : const CustomerHomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        backgroundColor: Color(0xFFE65100),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('🛒', style: TextStyle(fontSize: 72)),
            SizedBox(height: 16),
            Text('ماركت ميكي', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            CircularProgressIndicator(color: Colors.white),
          ]),
        ),
      );
}
