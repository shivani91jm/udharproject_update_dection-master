class StaffJoingInfo {
  String? month;

  StaffJoingInfo({this.month});

  StaffJoingInfo.fromJson(Map<String, dynamic> json) {
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    return data;
  }
}