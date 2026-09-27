import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'customer/home_screen.dart';

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

  Future<void> _submit() async {
    if (_email.text.trim().isEmpty || _password.text.isEmpty) return;
    setState(() => _loading = true);
    try {
      final auth = FirebaseAuth.instance;
      UserCredential credential;
      if (_register) {
        credential = await auth.createUserWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text,
        );
        await credential.user?.updateDisplayName(_name.text.trim());
      } else {
        credential = await auth.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text,
        );
      }
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CustomerHomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'تعذر تنفيذ العملية')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('ماركت ميكي')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            const Text('🛒', style: TextStyle(fontSize: 64)),
            Text(_register ? 'إنشاء حساب' : 'تسجيل الدخول', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            if (_register) TextField(controller: _name, decoration: const InputDecoration(labelText: 'الاسم الكامل')),
            const SizedBox(height: 12),
            TextField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'البريد الإلكتروني')),
            const SizedBox(height: 12),
            TextField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'كلمة المرور')),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: _loading ? const Center(child: CircularProgressIndicator()) : ElevatedButton(onPressed: _submit, child: Text(_register ? 'إنشاء الحساب' : 'دخول'))),
            TextButton(onPressed: () => setState(() => _register = !_register), child: Text(_register ? 'لديك حساب؟ دخول' : 'إنشاء حساب جديد')),
          ]),
        ),
      );
}
