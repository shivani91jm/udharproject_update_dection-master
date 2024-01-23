class DeparmentInfo {
  int? id;
  String? ownerId;
  String? bussinessId;
  String? departmentName;
  String? createdAt;
  String? updatedAt;

  DeparmentInfo(
      {this.id,
        this.ownerId,
        this.bussinessId,
        this.departmentName,
        this.createdAt,
        this.updatedAt});

  DeparmentInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    bussinessId = json['bussiness_id'];
    departmentName = json['department_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner_id'] = this.ownerId;
    data['bussiness_id'] = this.bussinessId;
    data['department_name'] = this.departmentName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}