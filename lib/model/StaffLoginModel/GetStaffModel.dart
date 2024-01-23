class Getstaff {
  int? id;
  int? staffId;
  String? salaryPaymentType;
  String? salaryAmount;
  String? salaryCycle;
  String? createdAt="12/13/23";
  String? updatedAt;

  Getstaff({this.id, this.staffId, this.salaryPaymentType, this.salaryAmount, this.salaryCycle, this.createdAt, this.updatedAt});

  Getstaff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    salaryPaymentType = json['salary_payment_type'];
    salaryAmount = json['salary_amount'];
    salaryCycle = json['salary_cycle'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['salary_payment_type'] = this.salaryPaymentType;
    data['salary_amount'] = this.salaryAmount;
    data['salary_cycle'] = this.salaryCycle;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}