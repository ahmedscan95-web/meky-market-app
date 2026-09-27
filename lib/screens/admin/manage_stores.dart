import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageStores extends StatelessWidget {
  const ManageStores({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('إدارة المتاجر')), body: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('stores').snapshots(), builder: (_, s) { if (!s.hasData) return const Center(child: CircularProgressIndicator()); return ListView(children: s.data!.docs.map((d) { final x = d.data() as Map<String, dynamic>; return ListTile(title: Text(x['name'] ?? ''), subtitle: Text(x['type'] ?? ''), trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete())); }).toList()); }));
}
