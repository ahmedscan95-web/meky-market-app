import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendRequestScreen extends StatefulWidget {
  const SendRequestScreen({super.key});
  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  final _msgCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String _type = 'inquiry';
  bool _loading = false;

  Future<void> _send() async {
    if (_msgCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اكتب رسالتك أولاً')),
      );
      return;
    }
    setState(() => _loading = true);
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('requests').add({
      'type': _type,
      'message': _msgCtrl.text.trim(),
      'phone': _phoneCtrl.text.trim(),
      'user_name': user?.displayName ?? 'مجهول',
      'uid': user?.uid,
      'status': 'pending',
      'created_at': FieldValue.serverTimestamp(),
    });
    _msgCtrl.clear();
    _phoneCtrl.clear();
    if (mounted) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ تم إرسال طلبك'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('إرسال طلب')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              TextField(
                controller: _msgCtrl,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'اكتب رسالتك',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف (اختياري)',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                        onPressed: _send,
                        icon: const Icon(Icons.send),
                        label: const Text('إرسال الطلب'),
                      ),
              ),
            ],
          ),
        ),
      );
}
