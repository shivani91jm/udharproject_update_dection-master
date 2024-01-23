class GetStaffAttendance {
  int? id;
  int? staffId;
  int? businessOwnerId;
  int? businessId;
  String? attendanceMarks;
  String? punchingInTiming;
  String? punchingOutTiming;
  String? punchingInAddress;
  String? punchingOutAddress;
  String? whoAttendanceMakeEnter;
  String? lateFineTime;
  String? lateFineAmount;
  String? lateFineType;
  String? exessBreaksTime;
  String? exessBreaksFineAmount;
  String? exessBreaksType;
  String? earlyOutTime;
  String? earlyFineAmount;
  String? earlyType;
  String? overtimeHours;
  String? overtimeType;
  String? overtimeSlabAmount;
  String? overtimeTotalAmount;
  String? createdAt;
  String? updatedAt;

  GetStaffAttendance(
      {this.id,
        this.staffId,
        this.businessOwnerId,
        this.businessId,
        this.attendanceMarks,
        this.punchingInTiming,
        this.punchingOutTiming,
        this.punchingInAddress,
        this.punchingOutAddress,
        this.whoAttendanceMakeEnter,
        this.lateFineTime,
        this.lateFineAmount,
        this.lateFineType,
        this.exessBreaksTime,
        this.exessBreaksFineAmount,
        this.exessBreaksType,
        this.earlyOutTime,
        this.earlyFineAmount,
        this.earlyType,
        this.overtimeHours,
        this.overtimeType,
        this.overtimeSlabAmount,
        this.overtimeTotalAmount,
        this.createdAt,
        this.updatedAt});

  GetStaffAttendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    businessOwnerId = json['business_owner_id'];
    businessId = json['business_id'];
    attendanceMarks = json['attendance_marks'];
    punchingInTiming = json['punching_in_timing'];
    punchingOutTiming = json['punching_out_timing'];
    punchingInAddress = json['punching_in_address'];
    punchingOutAddress = json['punching_out_address'];
    whoAttendanceMakeEnter = json['who_attendance_make_enter'];
    lateFineTime = json['late_fine_time'];
    lateFineAmount = json['late_fine_amount'];
    lateFineType = json['late_fine_type'];
    exessBreaksTime = json['exess_breaks_time'];
    exessBreaksFineAmount = json['exess_breaks_fine_amount'];
    exessBreaksType = json['exess_breaks_type'];
    earlyOutTime = json['early_out_time'];
    earlyFineAmount = json['early_fine_amount'];
    earlyType = json['early_type'];
    overtimeHours = json['overtime_hours'];
    overtimeType = json['overtime_type'];
    overtimeSlabAmount = json['overtime_slab_amount'];
    overtimeTotalAmount = json['overtime_total_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['business_owner_id'] = this.businessOwnerId;
    data['business_id'] = this.businessId;
    data['attendance_marks'] = this.attendanceMarks;
    data['punching_in_timing'] = this.punchingInTiming;
    data['punching_out_timing'] = this.punchingOutTiming;
    data['punching_in_address'] = this.punchingInAddress;
    data['punching_out_address'] = this.punchingOutAddress;
    data['who_attendance_make_enter'] = this.whoAttendanceMakeEnter;
    data['late_fine_time'] = this.lateFineTime;
    data['late_fine_amount'] = this.lateFineAmount;
    data['late_fine_type'] = this.lateFineType;
    data['exess_breaks_time'] = this.exessBreaksTime;
    data['exess_breaks_fine_amount'] = this.exessBreaksFineAmount;
    data['exess_breaks_type'] = this.exessBreaksType;
    data['early_out_time'] = this.earlyOutTime;
    data['early_fine_amount'] = this.earlyFineAmount;
    data['early_type'] = this.earlyType;
    data['overtime_hours'] = this.overtimeHours;
    data['overtime_type'] = this.overtimeType;
    data['overtime_slab_amount'] = this.overtimeSlabAmount;
    data['overtime_total_amount'] = this.overtimeTotalAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}