import 'package:frontend_bisarj/model/charger_model.dart';

import 'geo_point_model.dart';

class ChargingStationModel {
  String? id;
  String? stationName;
  String? stationAddress;
  String? status;
  GeoPointModel? stationLocation;
  String? avgReviewCount;
  String? stationImage;
  List<AmenitiesModel>? amenities;
  String? about;
  List<ChargerModel>? chargerModel;

  num? totalReview;

  ChargingStationModel({
    this.id,
    this.stationName,
    this.stationAddress,
    this.status,
    this.stationLocation,
    this.avgReviewCount,
    this.stationImage,
    this.amenities,
    this.about,
    this.chargerModel,
    this.totalReview,
  });

  ChargingStationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stationName = json['stationName'];
    stationAddress = json['stationAddress'];
    status = json['status'];
    stationLocation = json['stationLocation'] != null
        ? new GeoPointModel.fromJson(json['stationLocation'])
        : null;
    avgReviewCount = json['avgReviewCount'];
    stationImage = json['stationImage'];
    if (json['amenities'] != null) {
      amenities = <AmenitiesModel>[];
      json['amenities'].forEach((v) {
        amenities!.add(AmenitiesModel.fromJson(v));
      });
    }
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stationName'] = this.stationName;
    data['stationAddress'] = this.stationAddress;
    data['status'] = this.status;
    data['avgReviewCount'] = this.avgReviewCount;
    data['stationImage'] = this.stationImage;
    if (this.amenities != null) {
      data['amenities'] = this.amenities!.map((v) => v.toJson()).toList();
    }
    data['about'] = this.about;
    if (this.stationLocation != null) {
      data['stationLocation'] = this.stationLocation!.toJson();
    }
    return data;
  }
}

class AmenitiesModel {
  String? image;
  String? name;
  String? id;

  AmenitiesModel({this.image, this.name});

  AmenitiesModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}
