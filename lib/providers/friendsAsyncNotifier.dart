

import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:youth_connect/models/Friend.dart';
import 'package:youth_connect/models/FriendsResponse.dart';

class FriendsAsyncNotifier extends AsyncNotifier<List<Friend>> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  @override
  FutureOr<List<Friend>> build()async  {
    // TODO: implement build
    return await fetchFriends() as List<Friend>;
    throw UnimplementedError();
  }

  Future<dynamic> fetchFriends()async{
    final String? accountId= await secureStorage.read(key: 'account_id');
    final accessToken = await secureStorage.read(key:'access_token');

    final response = await http.get(
      Uri.parse('http://localhost:8080/friends/${accountId}'),
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
        'Authorization':'Bearer $accessToken'
      },
    );
    final responseData = FriendsResponse.fromJson(jsonDecode(response.body));
    if(response.statusCode==200)
      return responseData?.authData?.friends;
    else
      throw Exception('Failed to fetch ${response.statusCode}');
  }

}

final friendsProvider =  AsyncNotifierProvider<FriendsAsyncNotifier,List<Friend>>(FriendsAsyncNotifier.new);