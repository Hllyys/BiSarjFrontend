import 'package:frontend_bisarj/model/vehicle_model.dart';

class VehicleListModel {
  String? name;

  List<VehicleModel>? vehicleModel;

  VehicleListModel({
    this.vehicleModel,
    this.name,
  });

  VehicleListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['VehicleModel'] != null) {
      vehicleModel = <VehicleModel>[];
      json['VehicleModel'].forEach((v) {
        vehicleModel!.add(new VehicleModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.vehicleModel != null) {
      data['VehicleModel'] = this.vehicleModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
