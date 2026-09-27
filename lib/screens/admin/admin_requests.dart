import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRequests extends StatelessWidget {
  const AdminRequests({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('الطلبات والمراسلات')), body: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('requests').orderBy('created_at', descending: true).snapshots(), builder: (_, s) { if (!s.hasData) return const Center(child: CircularProgressIndicator()); if (s.data!.docs.isEmpty) return const Center(child: Text('لا توجد طلبات')); return ListView(padding: const EdgeInsets.all(12), children: s.data!.docs.map((d) { final x = d.data() as Map<String, dynamic>; final status = x['status'] ?? 'pending'; return Card(child: ListTile(title: Text(x['message'] ?? ''), subtitle: Text('${x['user_name'] ?? 'مستخدم'} - ${x['type'] ?? ''}'), trailing: status == 'pending' ? PopupMenuButton<String>(onSelected: (v) => d.reference.update({'status': v}), itemBuilder: (_) => const [PopupMenuItem(value: 'approved', child: Text('قبول')), PopupMenuItem(value: 'rejected', child: Text('رفض'))]) : Text(status)); }).toList()); }));
}
