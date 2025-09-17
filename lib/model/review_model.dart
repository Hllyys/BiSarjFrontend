
class ReviewModel {
  String? id;
  String? userId;
  String? userName;
  String? userImage;
  String? reviewText;
  double? count;
  String? createDate;
  String? updateDate;

  ReviewModel({
    this.userName,
    this.userImage,
    this.reviewText,
    this.count,
    this.id,
    this.createDate,
    this.updateDate,
    this.userId,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userId = json['userId'];
    userImage = json['userImage'];
    reviewText = json['reviewText'];
    count = json['count'];
    id = json['id'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['reviewText'] = this.reviewText;
    data['count'] = this.count;
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    return data;
  }
}
