class AddOverTimeInfo {
  int? id;
  int? businessId;
  int? businessManId;
  String? salaryType;
  String? status;
  String? createdAt;
  String? updatedAt;
  AddOverTimeInfo(
      {this.id,
        this.businessId,
        this.businessManId,
        this.salaryType,
        this.status,
        this.createdAt,
        this.updatedAt});

  AddOverTimeInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    businessManId = json['business_man_id'];
    salaryType = json['salary_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_id'] = this.businessId;
    data['business_man_id'] = this.businessManId;
    data['salary_type'] = this.salaryType;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}