
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:youth_connect/models/PostResponse.dart';
import '../../models/Account.dart';


import '../models/UserResponse.dart';

final secureStorage =FlutterSecureStorage();

final getAllAccounts = FutureProvider((ref) async{
  final userId=await secureStorage.read(key: 'user_id');
  final accessToken = await secureStorage.read(key:'access_token');
  final response = await http.get(
    Uri.parse('http://localhost:8080/users/$userId'),
    headers: <String,String>{
      'Content-Type':'application/json; charset=UTF-8',
      'Authorization':'Bearer $accessToken'
      }
  );


  if (response.statusCode == 200) {
    final userResponse = UserResponse.fromJson(jsonDecode(response.body));
    return userResponse.user?.accounts??[];
  } else {
    throw Exception('Server Error: ${response.statusCode}');
  }


});

final getAccount=FutureProvider((ref)async{
  final account_id=await secureStorage.read(key: 'account_id');
  final accounts = await ref.watch(getAllAccounts.future);
  return accounts.firstWhere((account)=>account.id.toString()==account_id);
});

final getPostsByAccount = FutureProvider((ref)async{
  final account_id=await secureStorage.read(key:'account_id');
  final accessToken = await secureStorage.read(key:'access_token');

  final response = await http.get(
    Uri.parse('http://localhost:8080/accounts/$account_id/posts'),
    headers: <String,String>{
      'Content-Type':'application/json; charset=UTF-8',
      'Authorization':'Bearer $accessToken'
    }
  );

  if(response.statusCode==200)
  {
    final posts=PostResponse.fromJson(jsonDecode(response.body));
    return posts.posts;
  }
  else{
    throw Exception('Server Error: ${response.statusCode}');
  }


});


