import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeDashboard extends StatelessWidget { const EmployeeDashboard({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('لوحة الموظف')), body: StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection('users').doc('current').snapshots(), builder: (_, s) => const Center(child: Text('مرحباً بك في لوحة الموظف')))); }
