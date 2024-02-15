class StaffInfoModel {
  int? id;
  String? staffImage;
  String? staffName;
  String? salaryPaymentType;

  StaffInfoModel({this.id, this.staffImage, this.staffName, this.salaryPaymentType});

  StaffInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffImage = json['staff_image'];
    staffName = json['staff_name'];
    salaryPaymentType = json['salary_payment_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_image'] = this.staffImage;
    data['staff_name'] = this.staffName;
    data['salary_payment_type'] = this.salaryPaymentType;
    return data;
  }
}