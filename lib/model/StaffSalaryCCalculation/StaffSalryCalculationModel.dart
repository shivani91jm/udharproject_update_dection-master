import 'package:udharproject/model/StaffSalaryCCalculation/StaffSalaryCalculationInfo.dart';

class StaffCalculationMenualModel {
  StaffSalryCalculationInfo? info;
  String? response;
  String? msg;

  StaffCalculationMenualModel({this.info, this.response, this.msg});

  StaffCalculationMenualModel.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new StaffSalryCalculationInfo.fromJson(json['info']) : null;
    response = json['response'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    data['response'] = this.response;
    data['msg'] = this.msg;
    return data;
  }
}