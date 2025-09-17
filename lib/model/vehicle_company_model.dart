class VehicleCompanyModel {
  String? id;
  String? companyImage;
  String? modelName;
  String? companyName;

  VehicleCompanyModel({
    this.id,
    this.companyImage,
    this.modelName,
    this.companyName,
  });

  VehicleCompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyImage = json['CompanyImage'];
    modelName = json['modelName'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CompanyImage'] = this.companyImage;
    data['modelName'] = this.modelName;
    data['companyName'] = this.companyName;
    return data;
  }
}
