

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:youth_connect/configuration/GoRouteConfig.dart';
import 'package:youth_connect/providers/friendsAsyncNotifier.dart';

class Friends extends ConsumerWidget {
  final FlutterSecureStorage secureStorage= FlutterSecureStorage();
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // TODO: implement build
    final friends=ref.watch(friendsProvider);
    return Scaffold(
      appBar: PreferredSize(preferredSize:Size.fromHeight(kToolbarHeight),
          child:Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [BoxShadow(
                  color: Color(0xFF4A4A4A),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 4)
              )],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                  //Navigator.pop(context);
                  if(context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/'); // Safety fallback
                  }
                },
                    icon:ImageIcon(
                      AssetImage('asset/images/arrow_back.png'),
                      size: 26,
                      color: Color(0xFFFFFFFF),
                    )),
                Text(
                  "Youthconnect",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(width: 40),
              ],
            ),
          )),
      body: friends.when(data: (data){
        print(data);
        return Text('data ${data?[0]!.account!.name}',style: TextStyle(color:Color(0xFFFFFFFF)),);
      }, error:(err,stack){
        print(err);
        return Text("error $err",style: TextStyle(color:Color(0xFFFFFFFF)));}, loading:()=>CircularProgressIndicator()),

    );
    throw UnimplementedError();
  }

}