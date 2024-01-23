import 'package:udharproject/model/DayWiseStaffList/Daily.dart';
import 'package:udharproject/model/DayWiseStaffList/Hourly.dart';
import 'package:udharproject/model/DayWiseStaffList/Monthly.dart';
import 'package:udharproject/model/DayWiseStaffList/Weekly.dart';

class StaffAttendanceDetails {
  List<Monthly>? monthly;
  List<Hourly>? hourly;
  List<Daily>? daily;
  List<Weekly>? weekly;

  StaffAttendanceDetails({this.monthly, this.hourly, this.daily, this.weekly});

  StaffAttendanceDetails.fromJson(Map<String, dynamic> json) {
    if (json['Monthly'] != null) {
      monthly = <Monthly>[];
      json['Monthly'].forEach((v) {
        monthly!.add(new Monthly.fromJson(v));
      });
    }
    if (json['Hourly'] != null) {
      hourly = <Hourly>[];
      json['Hourly'].forEach((v) {
        hourly!.add(new Hourly.fromJson(v));
      });
    }
    if (json['Daily'] != null) {
      daily = <Daily>[];
      json['Daily'].forEach((v) {
        daily!.add(new Daily.fromJson(v));
      });
    }
    if (json['Weekly'] != null) {
      weekly = <Weekly>[];
      json['Weekly'].forEach((v) {
        weekly!.add(new Weekly.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monthly != null) {
      data['Monthly'] = this.monthly!.map((v) => v.toJson()).toList();
    }
    if (this.hourly != null) {
      data['Hourly'] = this.hourly!.map((v) => v.toJson()).toList();
    }
    if (this.daily != null) {
      data['Daily'] = this.daily!.map((v) => v.toJson()).toList();
    }
    if (this.weekly != null) {
      data['Weekly'] = this.weekly!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}