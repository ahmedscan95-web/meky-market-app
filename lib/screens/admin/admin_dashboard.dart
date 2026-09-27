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
  int _index = 0;
  final _pages = const [
    AdminHomeTab(),
    ManageCategories(),
    ManageProducts(),
    ManageStores(),
    AdminRequests(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _pages[_index],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard, color: Color(0xFFE65100)),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: Icon(Icons.category_outlined),
              selectedIcon: Icon(Icons.category, color: Color(0xFFE65100)),
              label: 'الأقسام',
            ),
            NavigationDestination(
              icon: Icon(Icons.inventory_2_outlined),
              selectedIcon: Icon(Icons.inventory_2, color: Color(0xFFE65100)),
              label: 'المنتجات',
            ),
            NavigationDestination(
              icon: Icon(Icons.store_outlined),
              selectedIcon: Icon(Icons.store, color: Color(0xFFE65100)),
              label: 'المتاجر',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined),
              selectedIcon: Icon(Icons.notifications, color: Color(0xFFE65100)),
              label: 'الطلبات',
            ),
          ],
        ),
      );
}

class AdminHomeTab extends StatelessWidget {
  const AdminHomeTab({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('لوحة تحكم المالك - ميكي'),
          backgroundColor: const Color(0xFFE65100),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE65100), Color(0xFFFF8F00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'أهلاً، ميكي 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'لديك صلاحية كاملة على كل شيء',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'الإحصائيات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _statCard('المنتجات', 'products'),
            _statCard('المتاجر', 'stores'),
            _statCard('الطلبات', 'requests'),
          ],
        ),
      );

  Widget _statCard(String label, String collection) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(collection).snapshots(),
      builder: (context, snapshot) {
        final count = snapshot.data?.docs.length ?? 0;
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: Text(label),
            trailing: Text(
              '$count',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
