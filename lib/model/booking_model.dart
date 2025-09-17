import 'charger_model.dart';
import 'geo_point_model.dart';

class BookingModel {
  String? id;
  String? stationName;
  String? stationAddress;
  String? stationId;
  String? bookingStatus;
  num? totalAmount;
  num? subTotal;
  String? cancelReason;
  String? chargerType;
  String? chargerValue;
  String? chargerId;
  GeoPointModel? stationLocation;
  ChargerModel? chargerModel;
  String? createDate;
  String? time;
  bool isRemind = false;

  BookingModel({
    this.id,
    this.stationName,
    this.stationAddress,
    this.stationId,
    this.bookingStatus,
    this.totalAmount,
    this.subTotal,
    this.cancelReason,
    this.chargerType,
    this.chargerValue,
    this.chargerId,
    this.stationLocation,
    this.chargerModel,
    this.createDate,
    this.time,
    this.isRemind = false,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stationName = json['stationName'];
    stationAddress = json['stationAddress'];
    stationId = json['stationId'];
    bookingStatus = json['bookingStatus'];
    totalAmount = json['totalAmount'];
    subTotal = json['subTotal'];
    cancelReason = json['cancelReason'];
    chargerType = json['chargerType'];
    chargerValue = json['chargerValue'];
    chargerId = json['chargerId'];
    createDate = json['createDate'];
    time = json['updateDate'];
    stationLocation = json['stationLocation'] != null
        ? new GeoPointModel.fromJson(json['stationLocation'])
        : null;
    chargerModel =
        json['chargerModel'] != null ? new ChargerModel.fromJson(json['chargerModel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stationName'] = this.stationName;
    data['stationAddress'] = this.stationAddress;
    data['stationId'] = this.stationId;
    data['bookingStatus'] = this.bookingStatus;
    data['totalAmount'] = this.totalAmount;
    data['subTotal'] = this.subTotal;
    data['cancelReason'] = this.cancelReason;
    data['chargerType'] = this.chargerType;
    data['chargerValue'] = this.chargerValue;
    data['chargerId'] = this.chargerId;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.time;
    if (this.stationLocation != null) {
      data['stationLocation'] = this.stationLocation!.toJson();
    }
    if (this.chargerModel != null) {
      data['chargerModel'] = this.chargerModel!.toJson();
    }
    return data;
  }
}
