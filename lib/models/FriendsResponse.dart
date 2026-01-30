

import 'package:youth_connect/models/Friend.dart';

class FriendsResponse {
  final String? message;
  final bool? success;
  final AuthData? authData;

  FriendsResponse({this.message, this.success, this.authData});

  factory FriendsResponse.fromJson(Map<String,dynamic> json){
    return FriendsResponse(message: json['message'],success: json['success'],authData: AuthData.fromJson(json));
  }

}

class AuthData{
  final String? error;
  final int? status;
  final List<Friend>? friends;

  AuthData({this.error, this.status,this.friends});

  factory AuthData.fromJson(Map<String,dynamic> json){
    return (json['data'] is Map)?AuthData(error:json['data']['error'],status:json['data']['status'],):AuthData(friends:(json['data'] as List).map((json)=>Friend.fromJson(json)).toList() );
  }
}
