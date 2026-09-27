import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('المتاجر المتاحة')),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('stores')
              .where('active', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final docs = snapshot.data!.docs;
            if (docs.isEmpty) {
              return const Center(
                child: Text('لا توجد متاجر متاحة حالياً'),
              );
            }
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
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  ),
                );
              },
            );
          },
        ),
      );
}
