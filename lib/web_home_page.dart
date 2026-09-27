import 'package:flutter/material.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final isTablet = MediaQuery.of(context).size.width >= 800 && MediaQuery.of(context).size.width < 1200;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4F1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _topBar(isMobile),
            _heroSection(isMobile),
            _statsSection(),
            _productsSection(isMobile, isTablet),
            _storesSection(isMobile, isTablet),
            _featuresSection(isMobile),
            _ctaSection(),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _topBar(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 2)),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(0xFFE65100),
                    child: Icon(Icons.shopping_cart, color: Colors.white, size: 22),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'ماركت ميكي',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C1C1C),
                    ),
                  ),
                ],
              ),
              if (!isMobile)
                const Row(
                  children: [
                    _NavItem('الرئيسية'),
                    _NavItem('المتاجر'),
                    _NavItem('المنتجات'),
                    _NavItem('الطلبات'),
                    _NavItem('الدعم'),
                  ],
                ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE65100),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('تسجيل الدخول'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heroSection(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? Column(
                  children: [
                    _heroText(),
                    const SizedBox(height: 30),
                    _heroVisual(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _heroText()),
                    const SizedBox(width: 30),
                    Expanded(child: _heroVisual()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _heroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'أفضل تجربة تسوق',
            style: TextStyle(
              color: Color(0xFFE65100),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'تسوق كل ما تحتاجه\nمن متجر واحد',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            height: 1.1,
            color: Color(0xFF1C1C1C),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'من المنتجات الطازجة إلى الإكسسوارات اليومية، اكتشف تجربة تسوق ذكية وسريعة، مع دعم فني ودفع آمن ومتاجر موثوقة.',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE65100),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('تسوق الآن'),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFE65100),
                side: const BorderSide(color: Color(0xFFE65100), width: 1.5),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('استكشف المتاجر'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _heroVisual() {
    return Container(
      height: 430,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFFFFE0B2), Color(0xFFFFA726)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            right: 30,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 30,
            child: Container(
              width: 200,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.35),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          const Center(
            child: Icon(Icons.shopping_bag, size: 180, color: Color(0xFFE65100)),
          ),
        ],
      ),
    );
  }

  Widget _statsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: const [
              _StatCard('14k+', 'مستخدم نشط'),
              _StatCard('320', 'متجر'),
              _StatCard('8.9k', 'طلب يوميًا'),
              _StatCard('99.9%', 'موثوقية'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productsSection(bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 52),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text(
                'منتجات مميزة',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C1C1C),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'أفضل العروض والمنتجات الأكثر طلبًا من المتاجر المحلية',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 28),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.05,
                ),
                itemCount: 6,
                itemBuilder: (_, index) => const _ProductCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _storesSection(bool isMobile, bool isTablet) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 52),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text(
                'المتاجر الرائدة',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C1C1C),
                ),
              ),
              const SizedBox(height: 26),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.35,
                ),
                itemCount: 3,
                itemBuilder: (_, index) => const _StoreCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featuresSection(bool isMobile) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 52),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text(
                'لماذا ماركت ميكي؟',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C1C1C),
                ),
              ),
              const SizedBox(height: 28),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: const [
                  _FeatureCard(Icons.local_shipping, 'توصيل سريع'),
                  _FeatureCard(Icons.security, 'دفع آمن'),
                  _FeatureCard(Icons.store, 'متاجر موثوقة'),
                  _FeatureCard(Icons.support_agent, 'دعم مستمر'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ctaSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 52),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFFE65100), Color(0xFFFFA000)],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'ابدأ رحلتك الآن في متجر ميكي',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFE65100),
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('ابدأ الآن'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1C1C1C),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '© 2026 ماركت ميكي',
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                'جميع الحقوق محفوظة',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String text;
  const _NavItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF1C1C1C),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  const _StatCard(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE65100),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE0B2),
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: const Center(
              child: Icon(Icons.fastfood, size: 80, color: Color(0xFFE65100)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'منتج مميز',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'عرض خاص يوفر خصم كبير على هذا المنتج',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '120 ر.س',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE65100),
                      ),
                    ),
                    Icon(Icons.shopping_cart, color: Color(0xFFE65100)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StoreCard extends StatelessWidget {
  const _StoreCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xFFFFE0B2),
                child: Icon(Icons.store, color: Color(0xFFE65100)),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('متجر المدى', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('أطعمة ومشروبات', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'متجر موثوق يقدّم أفضل المنتجات المحلية والمواد الغذائية اليومية.',
            style: TextStyle(height: 1.6, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const Text('4.8 ★★★★★', style: TextStyle(color: Color(0xFFE65100))),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  const _FeatureCard(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Color(0xFFE65100)),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
