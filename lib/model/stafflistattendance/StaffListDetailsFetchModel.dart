import 'package:udharproject/model/stafflistattendance/StaffInfoModel.dart';

class StaffListDetailsFetchModel {
  String? response;
  String? msg;
  List<StaffInfoModel>? info;

  StaffListDetailsFetchModel({this.response, this.msg, this.info});

  StaffListDetailsFetchModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    msg = json['msg'];
    if (json['info'] != null) {
      info = <StaffInfoModel>[];
      json['info'].forEach((v) {
        info!.add(new StaffInfoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['msg'] = this.msg;
    if (this.info != null) {
      data['info'] = this.info!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
