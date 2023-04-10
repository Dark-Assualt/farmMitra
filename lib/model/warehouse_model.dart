class Warehouse {
  String name;
  double latitude;
  double longitude;
  String address;
  String traderId;

  Warehouse({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.traderId,
  });

  factory Warehouse.fromMap(Map<String, dynamic> map) {
    return Warehouse(
      name: map['name'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      traderId: map['traderId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'traderId': traderId,
    };
  }
}
