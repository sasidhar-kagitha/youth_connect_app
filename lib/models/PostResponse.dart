import 'Post.dart';

class PostResponse {
  final String? message;
  final bool? success;

  final List<Post>? posts;

  PostResponse({this.message,this.success,this.posts});

  factory PostResponse.fromJson(Map<String,dynamic> json){
    return PostResponse(message: json['message'],
        success: json['success'],
        posts: (json['data'] as List).map((i)=>Post.fromJson(i)).toList()
    );
  }

}