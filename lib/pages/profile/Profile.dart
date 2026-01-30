
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youth_connect/pages/profile/UserInfo.dart';
import 'package:youth_connect/pages/profile/UserPosts.dart';
import 'package:youth_connect/providers/future_provider.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // TODO: implement build
    final account = ref.watch(getAccount);


    print(account);
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
      body: account.when(
          data:(account){
            print(account.id);
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: [BoxShadow(
                            color: Color(0xFF4A4A4A),
                            blurRadius: 2,
                            spreadRadius: -1,
                            offset: Offset(0, 3)
                        )],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: UserInfo(account: account),
                            // child: Text(account.name,style:TextStyle(
                            //   color: Color(0xFFFFFFFF)
                            // ),),
                          ),
                          SizedBox(
                            width: 170,
                            child: ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF282828),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child:Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFFFFFFF),

                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Userposts()
                  ],
                ),
              ),
            );},
          error:(err,stack)=>Text("error $err"),
          loading:()=>CircularProgressIndicator(strokeWidth: 10))
    );
   // throw UnimplementedError();
  }

}
