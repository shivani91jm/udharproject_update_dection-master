import 'package:udharproject/model/ShowShiftrMorning/ShiftInfoModel.dart';

class ShowShiffListModel {
  String? response;
  String? msg;
  ShowShiftInfo? info;
  Null? errors;
  int? statusCode;

  ShowShiffListModel({this.response, this.msg, this.info, this.errors, this.statusCode});

  ShowShiffListModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    msg = json['msg'];
    info = json['info'] != null ? new ShowShiftInfo.fromJson(json['info']) : null;
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
    data['errors'] = this.errors;
    data['status_code'] = this.statusCode;
    return data;
  }
}