// lib/screens/map_picker_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  LatLng? selectedLocation;
  GoogleMapController? mapController;

  void _onTap(LatLng pos) {
    setState(() {
      selectedLocation = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Lokasi')),
      body: GoogleMap(
        onMapCreated: (controller) => mapController = controller,
        onTap: _onTap,
        initialCameraPosition: const CameraPosition(
          target: LatLng(-6.200000, 106.816666), // Jakarta
          zoom: 14,
        ),
        markers: selectedLocation != null
            ? {
                Marker(
                  markerId: const MarkerId('picked'),
                  position: selectedLocation!,
                )
              }
            : {},
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: selectedLocation == null
            ? null
            : () => Navigator.pop(context, selectedLocation),
        label: const Text("Pilih Lokasi"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
