import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/warehouse_model.dart';

class AddWarehouseScreen extends StatefulWidget {
  const AddWarehouseScreen({Key? key,}) : super(key: key);

  @override
  _AddWarehouseScreenState createState() => _AddWarehouseScreenState();
}

class _AddWarehouseScreenState extends State<AddWarehouseScreen> {
  final _nameController = TextEditingController();
  late GoogleMapController _mapController;
  LatLng? _selectedLocation;
  Position? _currentPosition;
  String? _address;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((position) {
      setState(() {
        _currentPosition = position;
      });
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      // Location services are disabled on the device.
      // You can prompt the user to enable location services here.
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // The user denied the request for location permissions.
        // You can prompt the user to grant location permissions here.
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // The user has previously denied the request for location permissions
      // and selected the "Don't ask again" option on the permission request dialog.
      // You can prompt the user to grant location permissions from the app settings.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current location of the user.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }


  Future<String> _getAddressFromLatLng(LatLng latLng) async {
    final placemarks = await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude);
    final place = placemarks.first;
    setState(() {
      _address = '${place.name}, ${place.locality}, ${place
          .administrativeArea}, ${place.country}';
    });

    return '${place.name}, ${place.locality}, ${place
        .administrativeArea}, ${place.country}';
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMapTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
    _mapController.animateCamera(CameraUpdate.newLatLng(location));
  }

  void _onSavePressed() async {
    final name = _nameController.text;
    final latitude = _selectedLocation!.latitude;
    final longitude = _selectedLocation!.longitude;
    final traderId = await FirebaseAuth.instance.currentUser!.uid;
    final address = _address;

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('warehouses')
        .where('traderId', isEqualTo: traderId)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      // User already has a warehouse saved
      final String warehouseId = snapshot.docs[0].id;
      await FirebaseFirestore.instance
          .collection('warehouses')
          .doc(warehouseId)
          .update({
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      });
    } else {
      // User doesn't have a warehouse saved yet
      await FirebaseFirestore.instance.collection('warehouses').add({
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'traderId': traderId,
      });
    }

    Navigator.pop(context);
  }
  final CollectionReference warehousesCollection =
  FirebaseFirestore.instance.collection('warehouses');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Warehouse'),
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
      : Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Warehouse Name',
              ),
              validator: (value) {
                if (value == null) {
                  return 'Please enter a name for your warehouse';
                }
                return null;
              },
            ),
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.hybrid,
              myLocationButtonEnabled: true,
              mapToolbarEnabled: true,
              onMapCreated: _onMapCreated,
              onTap: _onMapTap,
              initialCameraPosition: CameraPosition(
                target: LatLng(_currentPosition!.latitude,
                    _currentPosition!.longitude),
                zoom: 16,
              ),
              markers: _selectedLocation == null ? {
              Marker(
              markerId: const MarkerId('selected'),
              position: LatLng(_currentPosition!.latitude,
                  _currentPosition!.longitude),
              )
              }
                  : {
                Marker(
                  markerId: const MarkerId('selected'),
                  position: _selectedLocation!,
                ),
              },
            ),
          ),
          if (_selectedLocation != null) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: FutureBuilder<String>(
                future: _getAddressFromLatLng(_selectedLocation!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(_address!);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _selectedLocation == null ? null : _onSavePressed,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
