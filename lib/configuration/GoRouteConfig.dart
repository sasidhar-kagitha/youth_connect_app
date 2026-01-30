
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:youth_connect/pages/friends/Friends.dart';
import 'package:youth_connect/pages/home/Home.dart';
import 'package:youth_connect/pages/login/Login.dart';
import 'package:youth_connect/pages/profile/Profile.dart';

final FlutterSecureStorage secureStorage = FlutterSecureStorage();
final GoRouter router= GoRouter(
    initialLocation: "/login",
    routes:[
      GoRoute(
          path:"/login",
          name:"login",
          builder: (context,state)=>const Login(),
      ),
      GoRoute(
        path: "/home",
        name:"home",
        builder: (context,state)=>const Home(),
      ),
      GoRoute(
          path: "/profile",
          builder: (context,state)=>const Profile(),
      ),
      GoRoute(
          path:"/friends",
          builder: (context,state)=>Friends(),
      )
    ],
  errorPageBuilder: (context,state)=>MaterialPage(child: Center(child: Text("error!,something went wrong"),)),
  // redirect: (context,state)async{
  //     final access_token=await secureStorage.read(key: 'access_token');
  //     final bool loggedIn = access_token!=null;
  //     final bool logging = state.matchedLocation=="/login";
  //     if(!loggedIn)
  //     {
  //         return logging?null:"/login";
  //     }
  //     if(loggedIn)
  //     {
  //       return logging?"/home":null;
  //     }
  // }
);