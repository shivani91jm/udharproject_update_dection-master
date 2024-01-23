import 'package:udharproject/model/MonthlyWiseAttendance/AttendanceListInfo.dart';
import 'package:udharproject/model/MonthlyWiseAttendance/StaffAttendanceDetails.dart';
import 'package:udharproject/model/MonthlyWiseAttendance/ZeroClassModel.dart';

class MothlyWiseStaffAttendanceModel {
  ZeroModelClass? Zero;
  List<AttendanceListInfo>? info;

  MothlyWiseStaffAttendanceModel({this.Zero, this.info});

  MothlyWiseStaffAttendanceModel.fromJson(Map<String, dynamic> json) {
  Zero = json['0'] != null ? new ZeroModelClass.fromJson(json['0']) : null;
  if (json['info'] != null) {
  info = <AttendanceListInfo>[];
  json['info'].forEach((v) { info!.add(new AttendanceListInfo.fromJson(v)); });
  }
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (this.Zero != null) {
  data['0'] = this.Zero!.toJson();
  }
  if (this.info != null) {
  data['info'] = this.info!.map((v) => v.toJson()).toList();
  }
  return data;
  }
}