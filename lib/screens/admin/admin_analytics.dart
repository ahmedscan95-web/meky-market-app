import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRequests extends StatelessWidget {
  const AdminRequests({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('الطلبات والمراسلات')),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('requests')
              .orderBy('created_at', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final docs = snapshot.data!.docs;
            if (docs.isEmpty) {
              return const Center(child: Text('لا توجد طلبات'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: docs.length,
              itemBuilder: (context, i) {
                final d = docs[i].data() as Map<String, dynamic>;
                final status = d['status'] ?? 'pending';
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(d['message'] ?? ''),
                    subtitle: Text(
                      '${d['user_name'] ?? 'مجهول'} - ${d['type'] ?? ''}',
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        docs[i].reference.update({'status': value});
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(value: 'pending', child: Text('قيد المراجعة')),
                        const PopupMenuItem(value: 'approved', child: Text('موافق عليه')),
                        const PopupMenuItem(value: 'rejected', child: Text('مرفوض')),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
}
