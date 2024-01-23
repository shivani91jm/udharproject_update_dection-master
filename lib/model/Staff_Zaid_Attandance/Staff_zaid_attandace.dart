

class attendance_api {
  String? response;
  Msg? msg;
  Null? info;
  Null? errors;
  int? statusCode;

  attendance_api(
      {this.response, this.msg, this.info, this.errors, this.statusCode});

  attendance_api.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    msg = json['msg'] != null ? new Msg.fromJson(json['msg']) : null;
    info = json['info'];
    errors = json['errors'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    if (this.msg != null) {
      data['msg'] = this.msg!.toJson();
    }
    data['info'] = this.info;
    data['errors'] = this.errors;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Msg {
  String? businessManId;
  String? businessId;
  String? salaryPaymentType;
  String? staffId;
  String? date;

  Msg(
      {this.businessManId,
        this.businessId,
        this.salaryPaymentType,
        this.staffId,
        this.date});

  Msg.fromJson(Map<String, dynamic> json) {
    businessManId = json['business_man_id'];
    businessId = json['business_id'];
    salaryPaymentType = json['salary_payment_type'];
    staffId = json['staff_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_man_id'] = this.businessManId;
    data['business_id'] = this.businessId;
    data['salary_payment_type'] = this.salaryPaymentType;
    data['staff_id'] = this.staffId;
    data['date'] = this.date;
    return data;
  }
}
