import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'order_detail_screen.dart';
import 'order_model.dart';

class PesananScreen extends StatelessWidget {
  final VoidCallback? onBackToHome;

  const PesananScreen({super.key, this.onBackToHome});

  static final List<OrderModel> orders = [
    OrderModel(
      title: "Servis Mobil",
      status: "Sedang Dikerjakan",
      icon: Icons.car_repair,
      isCompleted: false,
    ),
    OrderModel(
      title: "AC Rumah",
      status: "Menunggu Teknisi",
      icon: Icons.ac_unit,
      isCompleted: false,
    ),
    OrderModel(
      title: "Tukang Harian",
      status: "Selesai",
      icon: Icons.handyman,
      isCompleted: true,
    ),
    OrderModel(
      title: "Servis Motor",
      status: "Selesai",
      icon: Icons.electric_moped,
      isCompleted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            // Gunakan Future agar navigasi tidak bentrok lifecycle
            Future.microtask(() {
              if (onBackToHome != null) {
                onBackToHome!.call();
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) =>  HomeScreen()),
                );
              }
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Pesanan"),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Berlangsung"),
                Tab(text: "Selesai"),
              ],
            ),
          ),
          body: Column(
            children: [
              const Expanded(
                child: TabBarView(
                  children: [
                    PesananBerlangsungTab(),
                    PesananSelesaiTab(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.home),
                  label: const Text("Kembali ke Beranda"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    if (onBackToHome != null) {
                      onBackToHome!.call();
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) =>  HomeScreen()),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PesananBerlangsungTab extends StatelessWidget {
  const PesananBerlangsungTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ongoingOrders =
    PesananScreen.orders.where((o) => !o.isCompleted).toList();

    if (ongoingOrders.isEmpty) {
      return const Center(child: Text("Belum ada pesanan aktif."));
    }

    return ListView.builder(
      itemCount: ongoingOrders.length,
      itemBuilder: (context, index) {
        final order = ongoingOrders[index];
        return ListTile(
          leading: Icon(order.icon, color: Colors.orange),
          title: Text(order.title),
          subtitle: Text(order.status),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OrderDetailScreen(order: order),
              ),
            );
          },
        );
      },
    );
  }
}

class PesananSelesaiTab extends StatelessWidget {
  const PesananSelesaiTab({super.key});

  @override
  Widget build(BuildContext context) {
    final completedOrders =
    PesananScreen.orders.where((o) => o.isCompleted).toList();

    if (completedOrders.isEmpty) {
      return const Center(child: Text("Belum ada riwayat pesanan."));
    }

    return ListView.builder(
      itemCount: completedOrders.length,
      itemBuilder: (context, index) {
        final order = completedOrders[index];
        return ListTile(
          leading: Icon(order.icon, color: Colors.green),
          title: Text(order.title),
          subtitle: Text(order.status),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OrderDetailScreen(order: order),
              ),
            );
          },
        );
      },
    );
  }
}
