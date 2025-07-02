import 'package:flutter/material.dart';
import 'order_screen.dart';

class WorkerDetailScreen extends StatelessWidget {
  final String name;
  final String skill;
  final double rating;

  const WorkerDetailScreen({
    Key? key,
    required this.name,
    required this.skill,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.orange.shade100,
                child: const Icon(Icons.person, size: 50, color: Colors.deepOrange),
              ),
            ),
            const SizedBox(height: 20),
            Text("Nama", style: labelStyle),
            Text(name, style: valueStyle),
            const SizedBox(height: 10),
            Text("Keahlian", style: labelStyle),
            Text(skill, style: valueStyle),
            const SizedBox(height: 10),
            Text("Rating", style: labelStyle),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text(rating.toString(), style: valueStyle),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderScreen(workerName: name),
                        ),
                      );
                    },
                    child: const Text("Pesan"),
                  ),
                ),
              
              ],
            )
          ],
        ),
      ),
    );
  }

  TextStyle get labelStyle =>
      const TextStyle(fontSize: 14, color: Colors.grey);
  TextStyle get valueStyle =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
}