class AccountReference {
  final String? id;
  final String? name;
  final String? profilePic;

  AccountReference({this.id,this.name,this.profilePic});

  factory AccountReference.fromJson(Map<String,dynamic> json){
    return AccountReference(id:json['id'],name:json['name'],profilePic:json['profilePic']);
  }
}