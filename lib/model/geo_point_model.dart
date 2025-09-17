class GeoPointModel {
  final double latitude;
  final double longitude;

  GeoPointModel({
    required this.latitude,
    required this.longitude,
  });

  factory GeoPointModel.fromJson(Map<String, dynamic> json) {
    return GeoPointModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
