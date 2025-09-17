class BankDetailModel {
  String? bankName;
  String? accountNumber;
  String? nameAsBank;
  String? ifscCode;

  BankDetailModel({
    this.bankName,
    this.accountNumber,
    this.nameAsBank,
    this.ifscCode,
  });

  BankDetailModel.fromJson(Map<String, dynamic> json) {
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    nameAsBank = json['name_as_Bank'];
    ifscCode = json['ifscCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['name_as_Bank'] = this.nameAsBank;
    data['ifscCode'] = this.ifscCode;
    return data;
  }
}
