class Account{

  final String? id;
  final String? name;
  final String? bio;
  final String? profilePic;
  final String? type;
  final bool? isDefault;
  final bool? private;
  Account({this.id, this.name, this.bio, this.profilePic, this.type, this.isDefault, this.private});

  factory Account.fromJson(Map<String,dynamic> json){
    return Account(id:json['id'], name:json['name'],
        bio:json['bio'], profilePic:json['profilePic'], type:json['type'], isDefault:json['default']
        , private:json['private']);
  }

}