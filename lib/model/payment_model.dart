class PaymentModel {
  String? image;
  String? title;
  String? subTitle;
  bool isCheck;

  PaymentModel({
    this.image,
    this.title,
    this.subTitle,
    this.isCheck = false,
  });
}
