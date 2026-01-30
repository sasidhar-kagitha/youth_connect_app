
import 'package:youth_connect/models/AccountResponse.dart';

class Friend {
  final String? id;
  final String? status;
  final AccountResponse? account;
  final AccountResponse? friend;
  final String? createdAt;

  Friend({this.id, this.status, this.account, this.friend, this.createdAt});

  factory Friend.fromJson(Map<String,dynamic> json){
    return Friend(id:json['id'],status: json['status'],
        account:AccountResponse.fromJson(json['account']),
        friend: AccountResponse.fromJson(json['friend']),
        createdAt: json['createdAt']
    );
  }
}