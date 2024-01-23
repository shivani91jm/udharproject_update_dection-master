import 'package:udharproject/model/DayWiseStaffList/PendingAttedance.dart';

class MarkAttendanceInfo {
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
  var weeklyHolidays;
  String? createdAt;
  String? updatedAt;
  var staffNote;

  PendingAttedance? pendingAttedance;
  var seledted;
  MarkAttendanceInfo(
      {this.id,
        this.staffId,
        this.staffName,
        this.businessId,
        this.ownerId,
        this.salaryPaymentType,
        this.salaryAmount,
        this.salaryCycle,
        this.workingTimeType,
        this.totalMoney,
        this.totalMoneyStatus,
        this.weeklyHolidays,
        this.createdAt,
        this.updatedAt,
        this.staffNote,
        this.pendingAttedance,this.seledted=false});

  MarkAttendanceInfo.fromJson(Map<String, dynamic> json) {
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
    weeklyHolidays = json['weekly_holidays'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    staffNote = json['staff_note'];
    pendingAttedance = json['pending_attedance'] != null
        ? new PendingAttedance.fromJson(json['pending_attedance'])
        : null;
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
    data['weekly_holidays'] = this.weeklyHolidays;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['staff_note'] = this.staffNote;
    if (this.pendingAttedance != null) {
      data['pending_attedance'] = this.pendingAttedance!.toJson();
    }
    return data;
  }
}