class ShowShiftInfo {
  int? id;
  String? ownerId;
  String? bussinessId;
  String? shiftType;
  String? shiftName;
  String? startTime;
  String? endTime;
  String? breakHours;
  Null? workingHours;
  Null? name;
  String? createdAt;
  String? updatedAt;

  ShowShiftInfo(
      {this.id,
        this.ownerId,
        this.bussinessId,
        this.shiftType,
        this.shiftName,
        this.startTime,
        this.endTime,
        this.breakHours,
        this.workingHours,
        this.name,
        this.createdAt,
        this.updatedAt});

  ShowShiftInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    bussinessId = json['bussiness_id'];
    shiftType = json['shift_type'];
    shiftName = json['shift_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    breakHours = json['break_hours'];
    workingHours = json['working_hours'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner_id'] = this.ownerId;
    data['bussiness_id'] = this.bussinessId;
    data['shift_type'] = this.shiftType;
    data['shift_name'] = this.shiftName;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['break_hours'] = this.breakHours;
    data['working_hours'] = this.workingHours;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}