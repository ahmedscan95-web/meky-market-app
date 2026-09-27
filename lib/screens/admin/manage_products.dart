import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageProducts extends StatefulWidget {
  const ManageProducts({super.key});
  @override
  State<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  Future<void> _add() async {
    if (_nameCtrl.text.trim().isEmpty || _priceCtrl.text.isEmpty) return;
    await FirebaseFirestore.instance.collection('products').add({
      'name': _nameCtrl.text.trim(),
      'price': double.tryParse(_priceCtrl.text) ?? 0,
      'discount': 0,
      'final_price': double.tryParse(_priceCtrl.text) ?? 0,
      'quantity': 0,
      'active': true,
      'created_at': FieldValue.serverTimestamp(),
    });
    _nameCtrl.clear();
    _priceCtrl.clear();
    if (mounted) Navigator.pop(context);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة منتج جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'اسم المنتج'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _priceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'السعر'),
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
        appBar: AppBar(title: const Text('إدارة المنتجات')),
        floatingActionButton: FloatingActionButton(
          onPressed: _showDialog,
          backgroundColor: const Color(0xFFE65100),
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
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
                    subtitle: Text('${d['price'] ?? 0} ج.م'),
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
