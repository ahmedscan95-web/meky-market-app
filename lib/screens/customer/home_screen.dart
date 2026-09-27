import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login_screen.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('أهلاً ${FirebaseAuth.instance.currentUser?.displayName ?? 'بك'} 👋'),
          actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () async { await FirebaseAuth.instance.signOut(); if (context.mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())); })],
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('categories').where('active', isEqualTo: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Center(child: Text('خطأ: ${snapshot.error}'));
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
            final docs = snapshot.data!.docs;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(16)), child: const Text('كل احتياجاتك في مكان واحد 🛒', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                const SizedBox(height: 20),
                const Text('الأقسام', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...docs.map((doc) => Card(child: ListTile(leading: Text(doc.data()['emoji'] ?? '📦', style: const TextStyle(fontSize: 28)), title: Text(doc.data()['name'] ?? ''),))),
                if (docs.isEmpty) const Center(child: Padding(padding: EdgeInsets.all(32), child: Text('لا توجد أقسام حالياً'))),
              ],
            );
          },
        ),
      );
}
