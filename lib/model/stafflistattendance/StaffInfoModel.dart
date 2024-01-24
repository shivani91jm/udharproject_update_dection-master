class StaffInfoModel {
  int? staffId;
  String? staffImage;
  String? staffName;
  String? salaryPaymentType;

  StaffInfoModel({this.staffId, this.staffImage, this.staffName, this.salaryPaymentType});

  StaffInfoModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    staffImage = json['staff_image'];
    staffName = json['staff_name'];
    salaryPaymentType = json['salary_payment_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['staff_image'] = this.staffImage;
    data['staff_name'] = this.staffName;
    data['salary_payment_type'] = this.salaryPaymentType;
    return data;
  }
}