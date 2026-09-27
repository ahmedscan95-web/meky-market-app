import 'package:flutter/material.dart';

class ManageEmployees extends StatelessWidget {
  const ManageEmployees({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
        appBar: AppBar(title: Text('إدارة الموظفين')),
        body: Center(
          child: Text('قيد التطوير - أضف الموظفين من Firebase Console'),
        ),
      );
}
