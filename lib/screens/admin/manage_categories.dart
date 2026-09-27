import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageCategories extends StatefulWidget {
  const ManageCategories({super.key});
  @override
  State<ManageCategories> createState() => _ManageCategoriesState();
}

class _ManageCategoriesState extends State<ManageCategories> {
  final _nameCtrl = TextEditingController();
  final _emojiCtrl = TextEditingController(text: '📦');

  Future<void> _add() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    await FirebaseFirestore.instance.collection('categories').add({
      'name': _nameCtrl.text.trim(),
      'emoji': _emojiCtrl.text.trim(),
      'active': true,
      'created_at': FieldValue.serverTimestamp(),
    });
    _nameCtrl.clear();
    _emojiCtrl.text = '📦';
    if (mounted) Navigator.pop(context);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة قسم جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _emojiCtrl,
              decoration: const InputDecoration(labelText: 'الإيموجي'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'اسم القسم'),
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
        appBar: AppBar(title: const Text('إدارة الأقسام')),
        floatingActionButton: FloatingActionButton(
          onPressed: _showDialog,
          backgroundColor: const Color(0xFFE65100),
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('categories').snapshots(),
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
                    leading: Text(d['emoji'] ?? '📦', style: const TextStyle(fontSize: 28)),
                    title: Text(d['name'] ?? ''),
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
