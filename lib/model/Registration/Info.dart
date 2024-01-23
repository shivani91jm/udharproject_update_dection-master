class Info {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? mobile;
  String? otp;
  int? roleId;
  Null? assignToOwnerId;
  Null? assginToBussinessesId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Info({this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.mobile,
    this.otp,
    this.roleId,
    this.assignToOwnerId,
    this.assginToBussinessesId,
    this.status,
    this.createdAt,
    this.updatedAt});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    otp = json['otp'];
    roleId = json['role_id'];
    assignToOwnerId = json['assign_to_owner_id'];
    assginToBussinessesId = json['assgin_to_bussinesses_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile'] = this.mobile;
    data['otp'] = this.otp;
    data['role_id'] = this.roleId;
    data['assign_to_owner_id'] = this.assignToOwnerId;
    data['assgin_to_bussinesses_id'] = this.assginToBussinessesId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}