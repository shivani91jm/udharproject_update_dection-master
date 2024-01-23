class AddNoteInfo {
  String? staffId;
  String? staffNote;
  String? updatedAt;
  String? createdAt;
  int? id;

  AddNoteInfo({this.staffId, this.staffNote, this.updatedAt, this.createdAt, this.id});

  AddNoteInfo.fromJson(Map<String, dynamic> json) {
  staffId = json['staff_id'];
  staffNote = json['staff_note'];
  updatedAt = json['updated_at'];
  createdAt = json['created_at'];
  id = json['id'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['staff_id'] = this.staffId;
  data['staff_note'] = this.staffNote;
  data['updated_at'] = this.updatedAt;
  data['created_at'] = this.createdAt;
  data['id'] = this.id;
  return data;
  }
  }
