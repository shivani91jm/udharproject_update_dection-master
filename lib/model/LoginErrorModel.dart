class LoginErrorModel{
  final String email;
const LoginErrorModel({  required this.email});
factory LoginErrorModel.fromJson(Map<String,dynamic> json){
    return LoginErrorModel(email:json['email'],);
  }

}