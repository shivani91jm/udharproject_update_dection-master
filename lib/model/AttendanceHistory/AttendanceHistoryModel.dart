import 'package:udharproject/model/AttendanceHistory/HistoryInfoModel.dart';

class AttendanceHistoryModel {
  String? response;
  String? msg;
  List<HistoryInfo>? info;
  Null? errors;
  int? statusCode;

  AttendanceHistoryModel({this.response, this.msg, this.info, this.errors, this.statusCode});

  AttendanceHistoryModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    msg = json['msg'];
    if (json['info'] != null) {
      info = <HistoryInfo>[];
      json['info'].forEach((v) {
        info!.add(new HistoryInfo.fromJson(v));
      });
    }
    errors = json['errors'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['msg'] = this.msg;
    if (this.info != null) {
      data['info'] = this.info!.map((v) => v.toJson()).toList();
    }
    data['errors'] = this.errors;
    data['status_code'] = this.statusCode;
    return data;
  }
}