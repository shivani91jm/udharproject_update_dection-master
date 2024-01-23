import 'package:udharproject/model/StaffSalaryCCalculation/ClossingMonth.dart';
import 'package:udharproject/model/StaffSalaryCCalculation/CurrentMonth.dart';

class StaffSalryCalculationInfo{
  CurrentMonth? currentMonth;
  List<ClossingMonth>? clossingMonth;
  StaffSalryCalculationInfo({this.currentMonth, this.clossingMonth});
  StaffSalryCalculationInfo.fromJson(Map<String, dynamic> json) {
    currentMonth = json['current_month'] != null
        ? new CurrentMonth.fromJson(json['current_month'])
        : null;
    if (json['clossing_month'] != null) {
      clossingMonth = <ClossingMonth>[];
      json['clossing_month'].forEach((v) {
        clossingMonth!.add(new ClossingMonth.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currentMonth != null) {
      data['current_month'] = this.currentMonth!.toJson();
    }
    if (this.clossingMonth != null) {
      data['clossing_month'] =
          this.clossingMonth!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}