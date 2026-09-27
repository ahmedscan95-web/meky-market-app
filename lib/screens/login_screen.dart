import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'customer/home_screen.dart';
import 'admin/admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  bool _register = false;
  bool _loading = false;
  bool _obscure = true;

  Future<void> _submit() async {
    if (_email.text.trim().isEmpty || _password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء ملء جميع الحقول')),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      final auth = FirebaseAuth.instance;
      UserCredential credential;
      if (_register) {
        if (_name.text.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('الرجاء إدخال الاسم')),
          );
          setState(() => _loading = false);
          return;
        }
        credential = await auth.createUserWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text,
        );
        await credential.user?.updateDisplayName(_name.text.trim());
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'name': _name.text.trim(),
          'email': _email.text.trim(),
          'role': 'customer',
          'created_at': FieldValue.serverTimestamp(),
        });
      } else {
        credential = await auth.signInWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text,
        );
      }
      if (!mounted) return;
      if (_email.text.trim().contains('admin')) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminDashboard()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const CustomerHomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'خطأ في التسجيل')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              const SizedBox(height: 20),
              const Text('🛒', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text(
                'ماركت ميكي',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                _register ? 'إنشاء حساب جديد' : 'تسجيل الدخول',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 32),
              if (_register)
                TextField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'الاسم الكامل'),
                ),
              const SizedBox(height: 16),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _password,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _submit,
                        child: Text(_register ? 'إنشاء الحساب' : 'دخول'),
                      ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => setState(() => _register = !_register),
                child: Text(
                  _register ? 'لديك حساب؟ دخول' : 'إنشاء حساب جديد',
                  style: const TextStyle(color: Color(0xFFE65100)),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'بيانات اختبار المالك:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('البريد: admin@meky.com', style: TextStyle(fontSize: 12)),
                    Text('كلمة المرور: Admin@123', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
}
