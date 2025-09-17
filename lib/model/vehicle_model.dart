class VehicleModel {
  String? id;
  String? name;
  String? image;
  String? companyId;
  String? batteryCapacity;
  List<String>? chargerType;
  String? vehicleNumber;


  VehicleModel({
    this.id,
    this.name,
    this.image,
    this.companyId,
    this.batteryCapacity,
    this.chargerType,
  });

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    companyId = json['companyId'];
    batteryCapacity = json['batteryCapacity'];
    chargerType = json['chargerType'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['companyId'] = this.companyId;
    data['batteryCapacity'] = this.batteryCapacity;
    data['chargerType'] = this.chargerType;

    return data;
  }
}
