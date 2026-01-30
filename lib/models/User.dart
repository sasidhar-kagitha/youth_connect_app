
import 'Account.dart';

class User {
  final String? id;
  final String? userName;
  final String? dob;
  final String? mobileNo;
  final String? createdAt;
  final String? email;
  final List<Account>? accounts;

  User({this.id,this.userName,this.dob,this.mobileNo,this.createdAt,this.email,this.accounts});

  factory User.fromJson(Map<String,dynamic> json){
    return User(id:json['id'],userName: json['userName'],dob:json['dob'],
    mobileNo: json['mobileNo'],createdAt: json['createdAt'],email: json['email'], accounts: json['accounts'] != null
          ? (json['accounts'] as List).map((i) => Account.fromJson(i)).toList()
          : null,
    );
  }
}

