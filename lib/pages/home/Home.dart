import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:youth_connect/models/PostResponse.dart';
import 'package:youth_connect/pages/home/PostCard.dart';
import 'package:http/http.dart' as http;
import 'package:youth_connect/pages/profile/Profile.dart';


import '../../models/Post.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final secureStorage= FlutterSecureStorage();

  late Future<List<Post>?> postsData;

  int pageNo=1,pageSize=10;

  Future<List<Post>?> fetchPosts(pageNo,pageSize) async {
    try{
      final accessToken= await secureStorage.read(key: 'access_token');
      final accountId = await secureStorage.read(key:'account_id');
      final response = await http.get(
        Uri.parse('http://localhost:8080/posts/feeds').replace(queryParameters: {
          "pageNo":pageNo.toString(),
          "pageSize":pageSize.toString(),
        }),
        headers:<String,String>{
          'Content-Type':'application/json; charset=UTF-8',
          'Authorization':'Bearer $accessToken',
          'X-Account-Id':'$accountId'
        }
      );
      if(response.statusCode==200)
        {
          PostResponse postResponse = PostResponse.fromJson(jsonDecode(response.body));
          print(postResponse.posts);
          return postResponse.posts;
        }
    }
    catch(e){
      throw Exception(e);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postsData=fetchPosts(pageNo,pageSize);
  }

  Future<void> handleRefresh()async
  {
    setState(() {
      postsData=fetchPosts(pageNo+1, pageSize);
    });
    await postsData;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(kToolbarHeight),
          child:Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow:[BoxShadow(
                color:Color(0xFF4A4A4A),
                blurRadius: 8,
                spreadRadius: 1,
                offset: Offset(0,4),
              )]

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing:20,
              children: [
                IconButton(
                  onPressed: (){},
                  icon: ImageIcon(
                    AssetImage('asset/images/add_circle.png'),
                    size:26,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                Text(
                  "Youthconnect",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                IconButton(
                  onPressed: (){},
                  icon: ImageIcon(
                    AssetImage('asset/images/notifications.png'),
                    size:26,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ],

            ),
          )
      ),
      body: FutureBuilder<List<Post>?>(
          future: postsData,
          builder: (BuildContext context,AsyncSnapshot<List<Post>?> snapshot){
            print(snapshot.error);
            print(snapshot.hasError);
            if(snapshot.connectionState==ConnectionState.waiting)
              {
                return const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                );
              }
            if(snapshot.hasError)
              {
                return Center(child: Text("error",style: TextStyle(color: Colors.redAccent),));
              }
            if(snapshot.hasData && snapshot.data!=null)
              {
                final posts=snapshot.data;
                return RefreshIndicator(
                  child: ListView.builder(
                      itemCount: posts?.length,
                      itemBuilder:(context,index){
                        return Postcard(posts?[index]);
                      }),
                  onRefresh:handleRefresh,
                );
              }
            return const Text("No posts");
          }),
      bottomNavigationBar:Container(
        height: 70,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow:[BoxShadow(
              color:Color(0xFF4A4A4A),
              blurRadius: 8,
              spreadRadius: 1,
              offset: Offset(0,-4),
            )]
          ),
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: (){},
              icon: ImageIcon(
                AssetImage('asset/images/Home.png'),
                size:26,
                color: Color(0xFFFFFFFF),
              ),
            ),
            IconButton(
              onPressed: (){
                context.push("/friends");
              },
              icon: ImageIcon(
                AssetImage('asset/images/friends_icon.png'),
                size:28,
                color: Color(0xFFFFFFFF),
              ),
            ),
            IconButton(
              onPressed: (){},
              icon: ImageIcon(
                AssetImage('asset/images/Search.png'),
                size:28,
                color: Color(0xFFFFFFFF),
              ),
            ),
            IconButton(
              onPressed: (){},
              icon: ImageIcon(
                AssetImage('asset/images/reel_icon.png'),
                size:28,
                color: Color(0xFFFFFFFF),
              ),
            ),
            IconButton(
              onPressed: (){
                //Navigator.push(context,MaterialPageRoute(builder: (context)=>const Profile()));
                context.push("/profile");
              },
              icon: ImageIcon(
                AssetImage('asset/images/account_circle.png'),
                size:28,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
    ));
    // TODO: implement build
    throw UnimplementedError();
  }
}