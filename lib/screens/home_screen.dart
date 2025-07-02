import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'category_screen.dart';
import 'order_screen.dart'; // <--- Tambahkan ini

class HomeScreen extends StatelessWidget {
  final Color primaryColor = Colors.orange;

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.build, 'label': 'Otomotif'},
    {'icon': Icons.local_shipping, 'label': 'Logistik'},
    {'icon': Icons.cleaning_services, 'label': 'Cleaning'},
    {'icon': Icons.plumbing, 'label': 'Tukang'},
    {'icon': Icons.more_horiz, 'label': 'Lainnya'},
  ];

  final List<Map<String, dynamic>> popularServices = [
    {
      'icon': Icons.car_repair,
      'title': 'Servis Mobil',
      'desc': 'Perawatan & perbaikan',
      'color': Colors.orange
    },
    {
      'icon': Icons.home_repair_service,
      'title': 'Tukang Harian',
      'desc': 'Bangunan & Renovasi',
      'color': Colors.deepOrange
    },
    {
      'icon': Icons.cleaning_services,
      'title': 'Cleaning Rumah',
      'desc': 'Bersih cepat & rapi',
      'color': Colors.orangeAccent
    },
  ];

  HomeScreen({super.key});

  Widget bannerItem(String text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          const Icon(Icons.local_offer_rounded, color: Colors.white, size: 36),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget popularServiceCard(Map<String, dynamic> service, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: service['color'].withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: service['color'].withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(service['icon'], size: 32, color: service['color']),
            const SizedBox(height: 10),
            Text(
              service['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: service['color'],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              service['desc'],
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Beresin',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari layanan...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Masuk sebagai pengguna',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const Divider(height: 24),
                                ListTile(
                                  leading: const Icon(Icons.login),
                                  title: const Text('Login'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/login');
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.app_registration),
                                  title: const Text('Register'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/register');
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 130,
                  child: PageView(
                    controller: PageController(viewportFraction: 0.9),
                    children: [
                      bannerItem('Promo Tukang Pro BGT!', primaryColor),
                      bannerItem('Diskon Cleaning 120%', Colors.orangeAccent),
                      bannerItem('Gratis Ongkir Logistik!', Colors.deepOrange),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Kategori Jasa',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: categories.map((cat) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CategoryScreen(
                                    categoryLabel: cat['label'],
                                    icon: cat['icon'],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 90,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Icon(cat['icon'], size: 30, color: primaryColor),
                                  const SizedBox(height: 8),
                                  Text(cat['label'], textAlign: TextAlign.center),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Layanan Populer',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: popularServices.length,
                        itemBuilder: (context, index) {
                          final service = popularServices[index];
                          return popularServiceCard(
                            service,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => OrderScreen(workerName: service['title']),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
