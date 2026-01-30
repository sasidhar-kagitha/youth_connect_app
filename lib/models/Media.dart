class Media {

  final String? id;
  final String? parentId;
  final String? mediaUrl;
  final String? mediaType;
  final String? refType;
  final String?  createdAt;

  Media({this.id,this.parentId,this.mediaUrl,this.mediaType,this.refType,this.createdAt});

  factory Media.fromString(Map<String,dynamic> json){
    return  Media(
      id:json['id'],
      parentId: json['parentId'],
      mediaUrl: json['mediaUrl'],
      refType: json['refType'],
      createdAt: json['createdAt']
    );
  }

}