class GeoPointModel {
  final double latitude; // enlem
  final double longitude; // boylam

  const GeoPointModel({required this.latitude, required this.longitude});

  /// JSON obje -> { "latitude": 39.9, "longitude": 32.85 }
  factory GeoPointModel.fromJson(Map<String, dynamic> json) {
    final lat = (json['latitude'] as num).toDouble();
    final lng = (json['longitude'] as num).toDouble();
    return GeoPointModel(latitude: lat, longitude: lng);
  }

  /// OSM/Payload backend -> [lng, lat] (örn. [32.85, 39.9])
  factory GeoPointModel.fromBackendArray(List<dynamic> arr) {
    final lng = (arr[0] as num).toDouble();
    final lat = (arr[1] as num).toDouble();
    return GeoPointModel(latitude: lat, longitude: lng);
  }

  /// Uygulama içi JSON (latitude/longitude anahtarlarıyla)
  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };

  /// Backend’e mutation atarken gereken format: [lng, lat]
  List<double> toBackendArray() => [longitude, latitude];
}
