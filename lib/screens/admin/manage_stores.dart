import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageStores extends StatefulWidget {
  const ManageStores({super.key});
  @override
  State<ManageStores> createState() => _ManageStoresState();
}

class _ManageStoresState extends State<ManageStores> {
  final _nameCtrl = TextEditingController();
  final _typeCtrl = TextEditingController();

  Future<void> _add() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    await FirebaseFirestore.instance.collection('stores').add({
      'name': _nameCtrl.text.trim(),
      'type': _typeCtrl.text.trim(),
      'active': true,
      'created_at': FieldValue.serverTimestamp(),
    });
    _nameCtrl.clear();
    _typeCtrl.clear();
    if (mounted) Navigator.pop(context);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة متجر جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'اسم المتجر'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _typeCtrl,
              decoration: const InputDecoration(labelText: 'النوع'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          ElevatedButton(onPressed: _add, child: const Text('إضافة')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('إدارة المتاجر')),
        floatingActionButton: FloatingActionButton(
          onPressed: _showDialog,
          backgroundColor: const Color(0xFFE65100),
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('stores').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final docs = snapshot.data!.docs;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: docs.length,
              itemBuilder: (context, i) {
                final d = docs[i].data() as Map<String, dynamic>;
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(d['name'] ?? ''),
                    subtitle: Text(d['type'] ?? ''),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => docs[i].reference.delete(),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
}
