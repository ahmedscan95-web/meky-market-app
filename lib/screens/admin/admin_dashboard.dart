import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'manage_categories.dart';
import 'manage_products.dart';
import 'manage_stores.dart';
import 'manage_employees.dart';
import 'admin_requests.dart';
import 'admin_analytics.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int index = 0;
  final pages = const [AdminHomeTab(), ManageCategories(), ManageProducts(), ManageStores(), AdminRequests()];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: pages[index],
    bottomNavigationBar: NavigationBar(
      selectedIndex: index,
      onDestinationSelected: (i) => setState(() => index = i),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'الرئيسية'),
        NavigationDestination(icon: Icon(Icons.category_outlined), label: 'الأقسام'),
        NavigationDestination(icon: Icon(Icons.inventory_2_outlined), label: 'المنتجات'),
        NavigationDestination(icon: Icon(Icons.store_outlined), label: 'المتاجر'),
        NavigationDestination(icon: Icon(Icons.notifications_outlined), label: 'الطلبات'),
      ],
    ),
  );
}

class AdminHomeTab extends StatelessWidget {
  const AdminHomeTab({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('لوحة تحكم المالك - ميكي')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('مرحباً، ميكي 👋', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        _count('المنتجات', 'products'),
        _count('المتاجر', 'stores'),
        _count('العملاء', 'users'),
        const SizedBox(height: 20),
        ListTile(title: const Text('الموظفون'), leading: const Icon(Icons.people), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageEmployees()))),
        ListTile(title: const Text('التحليلات'), leading: const Icon(Icons.bar_chart), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminAnalytics()))),
      ],
    ),
  );
  Widget _count(String label, String collection) => StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection(collection).snapshots(),
    builder: (_, s) => Card(child: ListTile(title: Text(label), trailing: Text('${s.data?.docs.length ?? 0}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)))),
  );
}
