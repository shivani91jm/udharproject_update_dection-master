

import 'package:udharproject/model/DayWiseStaffList/StaffAttendanceDetails.dart';

class DayInfo{
  int? totalPresent;
  int? totalAbsent;
  int? totalHalfDay;
  int? totalPaidLeave;
  var totalPaidFine;
  int? totalPaidOvertime;
  StaffAttendanceDetails? staffAttendanceDetails;
  DayInfo(
      {this.totalPresent,
        this.totalAbsent,
        this.totalHalfDay,
        this.totalPaidLeave,
        this.totalPaidFine,
        this.totalPaidOvertime,
        this.staffAttendanceDetails});

  DayInfo.fromJson(Map<String, dynamic> json) {
    totalPresent = json['total-present'];
    totalAbsent = json['total-absent'];
    totalHalfDay = json['total-half-day'];
    totalPaidLeave = json['total-paid-leave'];
    totalPaidFine = json['total-paid-fine'];
    totalPaidOvertime = json['total-paid-overtime'];
    staffAttendanceDetails = json['staff-attendance-details'] != null ? new StaffAttendanceDetails.fromJson(json['staff-attendance-details']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['total-present'] = this.totalPresent;
    data['total-absent'] = this.totalAbsent;
    data['total-half-day'] = this.totalHalfDay;
    data['total-paid-leave'] = this.totalPaidLeave;
    data['total-paid-fine'] = this.totalPaidFine;
    data['total-paid-overtime'] = this.totalPaidOvertime;
    if (this.staffAttendanceDetails != null) {
      data['staff-attendance-details'] = this.staffAttendanceDetails!.toJson();
    }
    return data;
  }
}