import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('المتاجر المتاحة')), body: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('stores').where('active', isEqualTo: true).snapshots(), builder: (_, s) { if (!s.hasData) return const Center(child: CircularProgressIndicator()); return ListView(children: s.data!.docs.map((d) { final x = d.data() as Map<String, dynamic>; return Card(child: ListTile(title: Text(x['name'] ?? ''), subtitle: Text(x['description'] ?? ''), trailing: Text(x['type'] ?? ''))); }).toList()); }));
}
