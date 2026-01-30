
class AccountResponse {
  final String? id;
  final String? name;
  final String? bio;
  final String? profilePic;
  final bool? isPrivate;
  final String? type;

  AccountResponse({this.id,this.name,this.bio,this.profilePic,this.isPrivate,this.type});

  factory AccountResponse.fromJson(Map<String,dynamic> json){
    return AccountResponse(id:json['id'],
      name:json['name'],
      bio:json['bio'],
      profilePic: json['profilePic'],
      isPrivate: json['isPrivate'],
      type: json['type']
    );
  }

}