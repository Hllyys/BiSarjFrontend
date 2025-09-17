
class CheckInModel {
  String? id;
  String? userId;
  String? userName;
  String? userImage;
  String? reviewText;
  String? checkInType;
  DateTime? createDate;
  double? count;
  String? updateDate;

  CheckInModel({
    this.userName,
    this.userImage,
    this.reviewText,
    this.checkInType,
    this.id,
    this.createDate,
    this.updateDate,
    this.count,
    this.userId,
  });

  CheckInModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    reviewText = json['reviewText'];
    checkInType = json['checkInType'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['reviewText'] = this.reviewText;
    data['checkInType'] = this.checkInType;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    data['count'] = this.count;
    return data;
  }
}
