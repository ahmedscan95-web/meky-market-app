import 'package:flutter/material.dart';

class CustomerSupportScreen extends StatelessWidget {
  const CustomerSupportScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('خدمة العملاء')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'للتواصل مع خدمة العملاء،\nاستخدم قسم الطلبات أعلاه\nأو تواصل عبر واتساب المحل',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
}
