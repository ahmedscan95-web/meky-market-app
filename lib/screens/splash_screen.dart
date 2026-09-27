import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'admin/admin_dashboard.dart';
import 'customer/home_screen.dart';
import 'employee/employee_dashboard.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    final user = FirebaseAuth.instance.currentUser;
    if (!mounted) return;

    if (user == null) {
      _replace(const LoginScreen());
      return;
    }

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final role = snapshot.data()?['role'] as String? ?? 'customer';
      if (!mounted) return;
      _replace(_screenForRole(role));
    } catch (_) {
      if (mounted) _replace(const CustomerHomeScreen());
    }
  }

  Widget _screenForRole(String role) => switch (role) {
        'admin' => const AdminDashboard(),
        'employee' => const EmployeeDashboard(),
        _ => const CustomerHomeScreen(),
      };

  void _replace(Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        backgroundColor: Color(0xFFE65100),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('🛒', style: TextStyle(fontSize: 72)),
            SizedBox(height: 16),
            Text('ماركت ميكي',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            CircularProgressIndicator(color: Colors.white),
          ]),
        ),
      );
}
