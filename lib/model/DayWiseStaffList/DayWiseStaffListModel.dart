import 'package:udharproject/model/DayWiseStaffList/DayInfo.dart';
import 'package:udharproject/model/DayWiseStaffList/MarkAttendanceInfo.dart';

class DayWiseStaffListModel {
  var response;
 var msg;
  List<MarkAttendanceInfo>? markAttendanceInfo;
  String? markAttendanceStatus;
  DayInfo? info;
 var errors;
  int? statusCode;

  DayWiseStaffListModel({this.response, this.msg,this.markAttendanceInfo,this.markAttendanceStatus, this.info, this.errors, this.statusCode});

  DayWiseStaffListModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    msg = json['msg'];
    if (json['mark_attendance_info'] != null) {
      markAttendanceInfo = <MarkAttendanceInfo>[];
      json['mark_attendance_info'].forEach((v) {
        markAttendanceInfo!.add(new MarkAttendanceInfo.fromJson(v));
      });
    }
    markAttendanceStatus = json['mark_attendance_status'];
    info = json['info'] != null ? new DayInfo.fromJson(json['info']) : null;
    errors = json['errors'];
    statusCode = json['status_code'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['msg'] = this.msg;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    data['mark_attendance_status'] = this.markAttendanceStatus;
    if (this.markAttendanceInfo != null) {
      data['mark_attendance_info'] =
          this.markAttendanceInfo!.map((v) => v.toJson()).toList();
    }
    data['errors'] = this.errors;
    data['status_code'] = this.statusCode;
    return data;
  }
}