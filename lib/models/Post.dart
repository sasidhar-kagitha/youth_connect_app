
import 'package:youth_connect/models/AccountReference.dart';

import 'Media.dart';

class Post{
  final String? id;
  final String? caption;
  final String? description;
  final String? createdAt;
  final List<Media>? media;
  final AccountReference? account;

  Post({this.id,this.caption,this.description,this.createdAt,this.media,this.account});

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
      id:json['id'],
      caption: json['caption'],
      description: json['description'],
      createdAt: json['createdAt'],
      media: json['media']!=null
          ?(json['media'] as List).map((i)=>Media.fromString(i)).toList():
          null,
      account: AccountReference.fromJson(json['account'])

    );
  }


}