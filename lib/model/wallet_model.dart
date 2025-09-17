
class WalletModel {
  String? userId;
  String? id;
  int? status;
  String? requestStatus;
  int? amount;
  String? createDate;
  String? updateDate;
  bool isWithDraw = false;
  String? paymentMethod;
  String? paymentStatus;

  WalletModel({
    this.userId,
    this.id,
    this.status,
    this.requestStatus,
    this.amount,
    this.updateDate,
    this.createDate,
    this.isWithDraw = false,
    this.paymentMethod,
    this.paymentStatus,
  });

  WalletModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    status = json['status'];
    requestStatus = json['requestStatus'];
    amount = json['amount'];
    isWithDraw = json['isWithDraw'];
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['status'] = this.status;
    data['requestStatus'] = this.requestStatus;
    data['amount'] = this.amount;
    data['isWithDraw'] = this.isWithDraw;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentStatus'] = this.paymentStatus;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    return data;
  }
}
