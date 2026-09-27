import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageCategories extends StatelessWidget {
  const ManageCategories({super.key});
  Future<void> add(BuildContext context) async {
    final name = TextEditingController();
    final emoji = TextEditingController(text: '📦');
    await showDialog(context: context, builder: (_) => AlertDialog(title: const Text('إضافة قسم'), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: name, decoration: const InputDecoration(labelText: 'الاسم')), TextField(controller: emoji, decoration: const InputDecoration(labelText: 'الإيموجي'))]), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')), ElevatedButton(onPressed: () async { if (name.text.trim().isNotEmpty) await FirebaseFirestore.instance.collection('categories').add({'name': name.text.trim(), 'emoji': emoji.text.trim(), 'active': true, 'created_at': FieldValue.serverTimestamp()}); if (context.mounted) Navigator.pop(context); }, child: const Text('إضافة'))]));
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('إدارة الأقسام')), floatingActionButton: FloatingActionButton(onPressed: () => add(context), child: const Icon(Icons.add)), body: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('categories').snapshots(), builder: (_, s) { if (!s.hasData) return const Center(child: CircularProgressIndicator()); return ListView(children: s.data!.docs.map((d) { final x = d.data() as Map<String, dynamic>; return ListTile(leading: Text(x['emoji'] ?? '📦', style: const TextStyle(fontSize: 28)), title: Text(x['name'] ?? ''), trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete())); }).toList()); }));
}
