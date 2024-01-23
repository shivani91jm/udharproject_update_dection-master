class GetBusiness {
  int? id;
  String? businessName;
  int? numberOfStaffs;
  String? calMonthlySalary;
  String? hoursStaffWork;
  int? businessManId;
  String? createdAt;
  String? updatedAt;

  GetBusiness(
      {this.id,
        this.businessName,
        this.numberOfStaffs,
        this.calMonthlySalary,
        this.hoursStaffWork,
        this.businessManId,
        this.createdAt,
        this.updatedAt});

  GetBusiness.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    numberOfStaffs = json['number_of_staffs'];
    calMonthlySalary = json['cal_monthly_salary'];
    hoursStaffWork = json['hours_staff_work'];
    businessManId = json['business_man_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['number_of_staffs'] = this.numberOfStaffs;
    data['cal_monthly_salary'] = this.calMonthlySalary;
    data['hours_staff_work'] = this.hoursStaffWork;
    data['business_man_id'] = this.businessManId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}