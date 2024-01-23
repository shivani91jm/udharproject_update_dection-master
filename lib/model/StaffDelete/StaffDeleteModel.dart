class DeleteStaffModel {
  String? response;
 var msg;
  Null? info;
  Null? error;

  DeleteStaffModel({this.response, this.msg, this.info, this.error});

  DeleteStaffModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    msg = json['msg'];
    info = json['info'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['msg'] = this.msg;
    data['info'] = this.info;
    data['error'] = this.error;
    return data;
  }
}