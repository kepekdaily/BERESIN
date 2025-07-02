import 'package:flutter/material.dart';
import 'routes.dart';


// Ini adalah file PesananScreen kamu, bisa juga dipindah ke file terpisah.
class PesananScreen extends StatelessWidget {
  final VoidCallback onBackToHome;

  const PesananScreen({super.key, required this.onBackToHome});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            onBackToHome(); // Kembali ke tab Home
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
          body: const TabBarView(
            children: [
              PesananBerlangsungTab(),
              PesananSelesaiTab(),
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
    final List<String> ongoingOrders = [
      "Servis Mobil - Sedang Dikerjakan",
      "AC Rusak - Menunggu Teknisi",
    ];

    if (ongoingOrders.isEmpty) {
      return const Center(child: Text("Belum ada pesanan aktif."));
    }

    return ListView.builder(
      itemCount: ongoingOrders.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.pending_actions),
        title: Text(ongoingOrders[index]),
      ),
    );
  }
}

class PesananSelesaiTab extends StatelessWidget {
  const PesananSelesaiTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> completedOrders = [
      "Tukang Harian - Selesai",
      "Servis Motor - Selesai",
    ];

    if (completedOrders.isEmpty) {
      return const Center(child: Text("Belum ada riwayat pesanan."));
    }

    return ListView.builder(
      itemCount: completedOrders.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.check_circle),
        title: Text(completedOrders[index]),
      ),
    );
  }
}



void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // ke AuthScreen
      routes: appRoutes,
    ),
  );
}


