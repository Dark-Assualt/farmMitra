import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

    LatLng? position;
class GenerateMaps extends ChangeNotifier{
  String? finalAddress;
   Position? position;
   Position? get getPosition => position;

   // String get getFinalAddress => finalAddress;
   // GoogleMapController googleMapController;

  Future getCurrentLocation() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied || permission ==
    LocationPermission.deniedForever) {
      print("permission not given");
    }
    else {
      var positionData = await GeolocatorPlatform.instance.getCurrentPosition();
      position = positionData;
      final cords = geoCo.Coordinates(
          positionData.latitude, positionData.longitude);
      var address = await geoCo.Geocoder.local.findAddressesFromCoordinates(
          cords);
      String mainAddress = address.first.addressLine;
      print(mainAddress);
      finalAddress = mainAddress;

    }
    notifyListeners();
  }


}