import 'package:udharproject/model/MonthlyWiseStaffListModel/GetStaffAttendance.dart';

class Weekly {
  int? id;
  int? staffId;
  String? staffName;
  int? businessId;
  int? ownerId;
  String? salaryPaymentType;
  String? salaryAmount;
  String? salaryCycle;
  String? workingTimeType;
  var total_money;
  var total_money_status;
  String? createdAt;
  String? updatedAt;
  String? attandancStatus;
  List<GetStaffAttendance>? getStaffAttendance;

  Weekly(
      {this.id,
        this.staffId,
        this.staffName,
        this.businessId,
        this.ownerId,
        this.salaryPaymentType,
        this.salaryAmount,
        this.salaryCycle,
        this.workingTimeType,
        this.total_money,
        this.total_money_status,
        this.createdAt,
        this.updatedAt,
        this.attandancStatus,
        this.getStaffAttendance});

  Weekly.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    businessId = json['business_id'];
    ownerId = json['owner_id'];
    salaryPaymentType = json['salary_payment_type'];
    salaryAmount = json['salary_amount'];
    salaryCycle = json['salary_cycle'];
    workingTimeType = json['working_time_type'];
    total_money = json['total_money'];
    total_money_status = json['total_money_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    attandancStatus = json['attandanc_status'];
    if (json['get_staff_attendance'] != null) {
      getStaffAttendance = <GetStaffAttendance>[];
      json['get_staff_attendance'].forEach((v) {
        getStaffAttendance!.add(new GetStaffAttendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['business_id'] = this.businessId;
    data['owner_id'] = this.ownerId;
    data['salary_payment_type'] = this.salaryPaymentType;
    data['salary_amount'] = this.salaryAmount;
    data['salary_cycle'] = this.salaryCycle;
    data['working_time_type'] = this.workingTimeType;
    data['total_money'] = this.total_money;
    data['total_money_status'] = this.total_money_status;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['attandanc_status'] = this.attandancStatus;
    if (this.getStaffAttendance != null) {
      data['get_staff_attendance'] =
          this.getStaffAttendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}