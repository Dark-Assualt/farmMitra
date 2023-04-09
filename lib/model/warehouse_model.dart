class Warehouse {
  String name;
  double latitude;
  double longitude;
  String traderId;

  Warehouse({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.traderId,
  });

  factory Warehouse.fromMap(Map<String, dynamic> map) {
    return Warehouse(
      name: map['name'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      traderId: map['traderId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'traderId': traderId,
    };
  }
}
