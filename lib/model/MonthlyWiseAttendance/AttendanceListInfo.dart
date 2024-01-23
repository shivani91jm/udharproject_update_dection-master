import 'package:udharproject/model/MonthlyWiseAttendance/StaffAttendanceDetails.dart';

class AttendanceListInfo{
  int? id;
  int? staffId;
  String? staffName;
  int? businessId;
  int? ownerId;
  String? salaryPaymentType;
  String? salaryAmount;
  String? salaryCycle;
  String? workingTimeType;
  String? totalMoney;
  String? totalMoneyStatus;
  String? createdAt;
  String? updatedAt;
  String? date;
  String? staffNote;
  var attandancStatus;
  List<StaffAttendanceDetails>? staffAttendanceDetails;


  AttendanceListInfo(
      {
        this.id, this.staffId, this.staffName, this.businessId, this.ownerId, this.salaryPaymentType,
        this.salaryAmount, this.salaryCycle, this.workingTimeType, this.totalMoney,
        this.totalMoneyStatus, this.createdAt, this.updatedAt, this.date, this.staffNote,
        this.attandancStatus,
        this.staffAttendanceDetails
      });

  AttendanceListInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    businessId = json['business_id'];
    ownerId = json['owner_id'];
    salaryPaymentType = json['salary_payment_type'];
    salaryAmount = json['salary_amount'];
    salaryCycle = json['salary_cycle'];
    workingTimeType = json['working_time_type'];
    totalMoney = json['total_money'];
    totalMoneyStatus = json['total_money_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    date = json['date'];
    staffNote = json['staff_note'];
    attandancStatus=json['attandanc_status'];
    if (json['staff_attendance'] != null) {
      staffAttendanceDetails = <StaffAttendanceDetails>[];
      json['staff_attendance'].forEach((v) {
        staffAttendanceDetails!.add(new StaffAttendanceDetails.fromJson(v));
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
    data['total_money'] = this.totalMoney;
    data['total_money_status'] = this.totalMoneyStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['date'] = this.date;
    data['staff_note'] = this.staffNote;
    data['attandanc_status'] = this.attandancStatus;
    if (this.staffAttendanceDetails != null) {
      data['staff_attendance'] = this.staffAttendanceDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
