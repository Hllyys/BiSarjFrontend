class ChargerModel {
  String? id;
  int? totalHours;
  String? chargerStatus;
  String? chargerImage;
  int? chargerMaxPower;
  String? chargerType;

  ChargerModel({
    this.id,
    this.totalHours,
    this.chargerStatus,
    this.chargerImage,
    this.chargerMaxPower,
    this.chargerType,
  });

  ChargerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalHours = json['totalHours'];
    chargerStatus = json['chargerStatus'];
    chargerImage = json['chargerImage'];
    chargerMaxPower = json['chargerMaxPower'];
    chargerType = json['chargerType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalHours'] = this.totalHours;
    data['chargerStatus'] = this.chargerStatus;
    data['chargerImage'] = this.chargerImage;
    data['chargerMaxPower'] = this.chargerMaxPower;
    data['chargerType'] = this.chargerType;
    return data;
  }
}