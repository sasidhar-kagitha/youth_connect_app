
import 'User.dart';

class UserResponse{
  final bool? success;
  final String? message;
  final User? user;

  UserResponse({this.success, this.message,this.user});

  factory UserResponse.fromJson(Map<String,dynamic> json)
  {
    return UserResponse(
        success: json['success'],
        message:json['message'],
        user:User.fromJson(json['data']),
    );
  }

}
class AuthData{
  final String? error;
  final int? status;
  final User? user;

  AuthData({this.error, this.status,this.user});

  factory AuthData.fromJson(Map<String,dynamic> json)
  {
    return AuthData(error:json['error'],
        status:json['status'],
        user:User.fromJson(json['user'] as Map<String,dynamic>)
    );
  }
}