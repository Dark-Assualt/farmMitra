import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart' as geoCo;


String finalAddress = "Searching address..";
class GenerateMaps extends ChangeNotifier{
   Position? position;

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