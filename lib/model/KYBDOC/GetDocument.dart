import 'package:flutter/material.dart';

class GetDocument {
  int? id;
  int? userId;
  String? profilePic;
  String? bankDocs;
  String? bankName;
  String? accoundNumber;
  String? bankIfsc;
  String? bankBranch;
  String? bankPhoto;
  String? adhaarDocs;
  String? adhaarNumber;
  String? adhaarDob;
  String? adhaarPhotoFront;
  String? adhaarPhotoBack;
  String? panDocs;
  String? panNumber;
  String? panPhotoFront;
  String? panPhotoBackend;
  String? gst_number;
  String? gst_photo;
  var test_key;
  String? createdAt;
  String? updatedAt;

  GetDocument(
      {this.id,
        this.userId,
        this.profilePic,
        this.bankDocs,
        this.bankName,
        this.accoundNumber,
        this.bankIfsc,
        this.bankBranch,
        this.bankPhoto,
        this.adhaarDocs,
        this.adhaarNumber,
        this.adhaarDob,
        this.adhaarPhotoFront,
        this.adhaarPhotoBack,
        this.panDocs,
        this.panNumber,
        this.panPhotoFront,
        this.panPhotoBackend,
        this.gst_number,
        this.gst_photo,
        this.test_key,
        this.createdAt,
        this.updatedAt});

  GetDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    profilePic = json['profile_pic'];
    bankDocs = json['bank_docs'];
    bankName = json['bank_name'];
    accoundNumber = json['accound_number'];
    bankIfsc = json['bank_ifsc'];
    bankBranch = json['bank_branch'];
    bankPhoto = json['bank_photo'];
    adhaarDocs = json['adhaar_docs'];
    adhaarNumber = json['adhaar_number'];
    adhaarDob = json['adhaar_dob'];
    adhaarPhotoFront = json['adhaar_photo_front'];
    adhaarPhotoBack = json['adhaar_photo_back'];
    panDocs = json['pan_docs'];
    panNumber = json['pan_number'];
    panPhotoFront = json['pan_photo_front'];
    panPhotoBackend = json['pan_photo_backend'];
    gst_number=json['gst_number'];
    gst_photo=json['gst_photo'];
    test_key=json['test_key'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['profile_pic'] = this.profilePic;
    data['bank_docs'] = this.bankDocs;
    data['bank_name'] = this.bankName;
    data['accound_number'] = this.accoundNumber;
    data['bank_ifsc'] = this.bankIfsc;
    data['bank_branch'] = this.bankBranch;
    data['bank_photo'] = this.bankPhoto;
    data['adhaar_docs'] = this.adhaarDocs;
    data['adhaar_number'] = this.adhaarNumber;
    data['adhaar_dob'] = this.adhaarDob;
    data['adhaar_photo_front'] = this.adhaarPhotoFront;
    data['adhaar_photo_back'] = this.adhaarPhotoBack;
    data['pan_docs'] = this.panDocs;
    data['pan_number'] = this.panNumber;
    data['pan_photo_front'] = this.panPhotoFront;
    data['pan_photo_backend'] = this.panPhotoBackend;
    data['gst_number']= this.gst_number;
    data['gst_photo']=this.gst_photo;
    data['test_key']=this.test_key;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}