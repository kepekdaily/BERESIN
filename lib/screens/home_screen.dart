import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
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
      'desc': 'Tukang bangunan ok',
      'color': Colors.blue
    },
    {
      'icon': Icons.cleaning_services,
      'title': 'Cleaning Rumah',
      'desc': 'Bersih, cepat, profesional',
      'color': Colors.green
    },
  ];

  HomeScreen({super.key});

  Widget bannerItem(String text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.white, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget popularServiceCard(Map<String, dynamic> service) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: service['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: service['color'], width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(service['icon'], size: 32, color: service['color']),
          const SizedBox(height: 8),
          Text(
            service['title'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: service['color'],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            service['desc'],
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ],
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
        title: const Text(
          'Beresin',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 🔧 Search bar dan ikon profil dengan Modal BottomSheet
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari layanan...',
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
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
                      child: const CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Banner
                SizedBox(
                  height: 140,
                  child: PageView(
                    controller: PageController(viewportFraction: 0.9),
                    children: [
                      bannerItem('Promo Tukang pro bgt', Colors.orange),
                      bannerItem('Jasa Cleaning Diskon 120%', Colors.green),
                      bannerItem('Gratis Ongkir Logistik', Colors.purple),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Kategori
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kategori Jasa',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: categories.map((cat) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryScreen(
                                    categoryLabel: cat['label'],
                                    icon: cat['icon'],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(cat['icon'],
                                      size: 32, color: Colors.blueAccent),
                                  const SizedBox(height: 8),
                                  Text(
                                    cat['label'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 14),
                                  ),
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

                // Layanan Populer
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Layanan Populer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: popularServices.length,
                        itemBuilder: (context, index) {
                          return popularServiceCard(popularServices[index]);
                        },
                      ),
                    ),
                  ],
                ),

                // Pesanan Terbaru
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pesanan Terbaru',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.build_circle, color: Colors.orange),
                          title: const Text('Tukang Harian'),
                          subtitle: const Text('Status: Selesai • 3 hari lalu'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.cleaning_services, color: Colors.green),
                          title: const Text('Cleaning Rumah'),
                          subtitle: const Text('Status: Diproses • Hari ini'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {},
                        ),
                      ],
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
