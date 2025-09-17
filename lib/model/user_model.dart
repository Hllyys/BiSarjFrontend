// import 'package:ev/model/bank_detail_model.dart';

import 'package:frontend_bisarj/model/bank_detail_model.dart';

class userModel {
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? dateTime;
  int? verify;
  int? isAdmin;
  String? contactNumber;
  String? id;
  DateTime? createDate;
  DateTime? updateDate;
  String? oneSignalPlayerId;
  bool? isTestUser;
  String? loginType;
  String? address;
  String? gender;
  String? dateOfBirth;
  String? country;
  String? password;
  BankDetailModel? bankDetailModel;
  num? walletAmount;
  List<String>? favorite;
  List<MyVehicleModel>? vehicleData;

  userModel({
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.dateTime,
    this.verify,
    this.isAdmin,
    this.contactNumber,
    this.id,
    this.createDate,
    this.updateDate,
    this.isTestUser,
    this.oneSignalPlayerId,
    this.loginType,
    this.address,
    this.country,
    this.dateOfBirth,
    this.gender,
    this.bankDetailModel,
    this.password,
    this.walletAmount,
    this.favorite,
    this.vehicleData,
  });

  userModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    image = json['image'];
    dateTime = json['dateTime'];
    verify = json['verify'];
    isAdmin = json['is_admin'];
    contactNumber = json['contact_number'];
    id = json['id'];
    isTestUser = json['isTestUser'];
    oneSignalPlayerId = json['oneSignalPlayerId'];
    loginType = json['loginType'];
    address = json['address'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    country = json['country'];
    bankDetailModel =
        json['bankDetailModel'] != null ? BankDetailModel.fromJson(json['bankDetailModel']) : null;
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    walletAmount = json['walletAmount'];
    favorite = json['favorite'].cast<String>();
    //vehicleData = json['vehicleData'] != null ? MyVehicleModel.fromJson(json['vehicleData']) : null;
    if (json['vehicleData'] != null) {
      vehicleData = <MyVehicleModel>[];
      json['vehicleData'].forEach((v) {
        vehicleData!.add(new MyVehicleModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['image'] = this.image;
    data['dateTime'] = this.dateTime;
    data['verify'] = this.verify;
    data['is_admin'] = this.isAdmin;
    data['contact_number'] = this.contactNumber;
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    data['oneSignalPlayerId'] = this.oneSignalPlayerId;
    data['isTestUser'] = this.isTestUser;
    data['loginType'] = this.loginType;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['country'] = this.country;
    data['walletAmount'] = this.walletAmount;
    if (this.bankDetailModel != null) {
      data['bankDetailModel'] = this.bankDetailModel!.toJson();
    }
    ;
    data['favorite'] = this.favorite;
    if (this.vehicleData != null) {
      data['vehicleData'] = this.vehicleData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyVehicleModel {
  String? vehicleNumber;
  String? vehicleId;

  MyVehicleModel({this.vehicleNumber, this.vehicleId});

  MyVehicleModel.fromJson(Map<String, dynamic> json) {
    vehicleNumber = json['vehicleNumber'];
    vehicleId = json['vehicleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicleNumber'] = this.vehicleNumber;
    data['vehicleId'] = this.vehicleId;
    return data;
  }
}
