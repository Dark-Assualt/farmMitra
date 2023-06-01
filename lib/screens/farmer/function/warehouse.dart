import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Warehouse {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String traderId;
  final String rate;

  Warehouse({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.traderId,
    required this.rate,
  });
}

class FarmerScreen extends StatefulWidget {
  const FarmerScreen({super.key});

  @override
  _FarmerScreenState createState() => _FarmerScreenState();
}

class _FarmerScreenState extends State<FarmerScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final List<Warehouse> _warehouses = [];

  LatLng? _currentLocation;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentLocation =
            LatLng(position.latitude, position.longitude);
      });
      await _getWarehouses();
    } catch (e) {
      print('Failed to get location: $e');
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _getWarehouses() async {
    final warehouses = FirebaseFirestore.instance.collection('warehouses');
    final snapshot = await warehouses.get();
    final Random random = Random();
    for (final doc in snapshot.docs) {
      final warehouse = Warehouse(
        name: doc['name'],
        address: doc['address'],
        latitude: doc['latitude'],
        longitude: doc['longitude'],
        traderId: doc['traderId'],
        rate: doc['rate'],
      );
      // if (_currentLocation != null) {
      //   final currentMarker = Marker(
      //     markerId: MarkerId('current'),
      //     position: _currentLocation!,
      //     infoWindow: InfoWindow(title: 'Current Location'),
      //   );
      //   _markers.add(currentMarker);
      // }

      final marker = Marker(
        markerId: MarkerId(doc.id),
        position: LatLng(
          warehouse.latitude + random.nextDouble() * 0.01 - 0.005,
          warehouse.longitude + random.nextDouble() * 0.01 - 0.005,
        ),
        infoWindow: InfoWindow(title: warehouse.name,),
      );
      setState(() {
        _markers.add(marker);
        _warehouses.add(warehouse);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }
    final halfWidth = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        title: Text('Warehouses',
          style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(
                            1.0,
                            1.0,
                          ),
                          blurRadius: 50.0,
                          spreadRadius: 0.1,
                        )]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GoogleMap(
                      myLocationButtonEnabled: true,
                      mapToolbarEnabled: true,
                      // trafficEnabled: true,
                      compassEnabled:true,
                      initialCameraPosition: CameraPosition(
                        target:
                        _currentLocation ?? LatLng(37.7749, -122.4194),
                        zoom: 14,
                      ),
                      markers: _markers,
                      onMapCreated: (controller) {
                        _controller.complete(controller);
                        },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Expanded(
              child: ListView.builder(
                itemCount: _warehouses.length,
                itemBuilder: (context, index) {
                  final warehouse = _warehouses[index];
                  final distance = _currentLocation != null
                      ? _calculateDistance(
                      _currentLocation!, LatLng(warehouse.latitude, warehouse.longitude))
                      : null;
                  final rate = warehouse.rate;
                  return SingleChildScrollView(
                    child: ListTile(
                      onTap: () => _openMapsUrl(warehouse),
                      title: Text(warehouse.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(warehouse.address),
                          if (distance != null)
                            Text('${distance.toStringAsFixed(2)} km away'),
                          if (rate != null)
                            Text(rate),
                        ],
                      ),
                    ),
                  );
                  },
              ),
            ),
          ],
      ),
    );
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const int earthRadius = 6371;
    final double latDistance = (end.latitude - start.latitude).abs() * pi / 180;
    final double lonDistance = (end.longitude - start.longitude).abs() * pi / 180;
    final double a = sin(latDistance / 2) * sin(latDistance / 2) +
        cos(start.latitude * pi / 180) *
            cos(end.latitude * pi / 180) *
            sin(lonDistance / 2) *
            sin(lonDistance / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distance = earthRadius * c;
    return distance;
  }
}

void _openMapsUrl(Warehouse warehouse) async{
  String mapsUrl = 'https://www.google.com/maps/search/?api=1&query=${warehouse.latitude},${warehouse.longitude}';
  if (await canLaunch(mapsUrl)) {
    await launch(mapsUrl);
  } else {
    print('Could not launch $mapsUrl');
  }
}