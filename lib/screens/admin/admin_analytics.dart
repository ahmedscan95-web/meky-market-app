import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminAnalytics extends StatelessWidget {
  const AdminAnalytics({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('التحليلات والإحصائيات')), body: ListView(padding: const EdgeInsets.all(16), children: [_stat('المنتجات', 'products'), _stat('المتاجر', 'stores'), _stat('العملاء', 'users'), _stat('الطلبات', 'requests')]));
  Widget _stat(String label, String collection) => StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection(collection).snapshots(), builder: (_, s) => Card(child: ListTile(title: Text('إجمالي $label'), trailing: Text('${s.data?.docs.length ?? 0}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))));
}
