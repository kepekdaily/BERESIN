import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'map_picker_screen.dart';

class OrderScreen extends StatefulWidget {
  final String workerName;

  const OrderScreen({Key? key, required this.workerName}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime? selectedDate;
  LatLng? pickedLocation;

  Future<void> _getAddressFromCoordinates(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address =
            '${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}';
        setState(() {
          locationController.text = address;
        });
      }
    } catch (e) {
      setState(() {
        locationController.text = 'Alamat tidak ditemukan';
      });
    }
  }

  void _submitOrder() {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Silakan pilih tanggal pengerjaan")),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Pesanan Berhasil"),
          content: Text(
            "Pekerja ${widget.workerName} akan segera menghubungi Anda.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Oke"),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (result != null) {
      setState(() {
        selectedDate = result;
      });
    }
  }

  TextStyle get labelStyle =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pesan ${widget.workerName}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text("Nama Pemesan", style: labelStyle),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Nama lengkap",
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 12),

              Text("Alamat/Lokasi", style: labelStyle),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        hintText: "Contoh: Jl. Mawar No.12",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) =>
                          val == null || val.isEmpty ? "Wajib diisi" : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.map),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MapPickerScreen(),
                        ),
                      );
                      if (result != null && result is LatLng) {
                        setState(() {
                          pickedLocation = result;
                        });
                        await _getAddressFromCoordinates(result);
                      }
                    },
                  ),
                ],
              ),
              if (pickedLocation != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Koordinat: ${pickedLocation!.latitude.toStringAsFixed(5)}, ${pickedLocation!.longitude.toStringAsFixed(5)}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),

              const SizedBox(height: 12),

              Text("Tanggal Pengerjaan", style: labelStyle),
              Row(
                children: [
                  Text(
                    selectedDate != null
                        ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                        : "Belum dipilih",
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: const Text("Pilih Tanggal"),
                  )
                ],
              ),
              const SizedBox(height: 12),

              Text("Catatan Tambahan", style: labelStyle),
              TextFormField(
                controller: noteController,
                decoration: const InputDecoration(
                  hintText: "Opsional",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text("Kirim Pesanan"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}