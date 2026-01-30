
import 'User.dart';

class LoginResponse {
  final AuthData? authdata;
  final String? message;
  final bool? success;
  LoginResponse({this.message,this.success,this.authdata});

  factory LoginResponse.fromJson(Map<String,dynamic> json){
    return LoginResponse(message: json['message'],success:json['success'],authdata: json['data'] != null
        ? AuthData.fromJson(json['data'] as Map<String, dynamic>)
        : null);
  }

}

class AuthData
{
  final String? error;
  final int? status;
  final String? accessToken;
  final String? refreshToken;
  final User? user;
  AuthData({this.accessToken,this.refreshToken,this.error,this.status,this.user});
  factory AuthData.fromJson(Map<String,dynamic> json){
    return AuthData(accessToken: json['accessToken'],
    refreshToken: json['refreshToken'],error:json['error'],status: json['status'],
      user:json['user']!=null?User.fromJson(json['user'] as Map<String,dynamic>):null,
    );
  }
}