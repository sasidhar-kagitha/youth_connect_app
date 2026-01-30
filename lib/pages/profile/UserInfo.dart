
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/Account.dart';
import '../../providers/future_provider.dart';

class UserInfo extends ConsumerWidget {
  final Account account;

  const UserInfo({super.key,required this.account});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // TODO: implement build

    final posts = ref.watch(getPostsByAccount);

    return posts.when(data:(posts){
      return SizedBox(
        height: 150,
        child: Padding(
          padding:EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child:account!.profilePic!.contains('.avif')?AvifImage.network(
                  '${account.profilePic}',
                  width:80,
                  height: 80,
                ):Image.network(
                  '${account.profilePic}',
                  width:80,
                  height: 80,
                ),
              ),
              SizedBox(width:20),
              Container(
                  padding: EdgeInsets.all(10),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${account.name}',
                        style: TextStyle(
                          color:Color(0xFFFFFFFF),
                          fontSize: 20,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text("${posts?.length==null?'0':posts!.length}",
                                  style: TextStyle(
                                    color:Color(0xFFFFFFFF),
                                    fontSize: 20,
                                    fontFamily: 'Roboto',
                                  ),),
                                Text("Posts",
                                  style: TextStyle(
                                    color:Color(0xFFFFFFFF),
                                    fontSize: 20,
                                    fontFamily: 'Roboto',
                                  ),)
                              ],
                            ),
                            SizedBox(width: 30,),
                            Column(
                              children: [
                                Text("13",
                                  style: TextStyle(
                                    color:Color(0xFFFFFFFF),
                                    fontSize: 20,
                                    fontFamily: 'Roboto',
                                  ),),
                                Text("Friends",
                                  style: TextStyle(
                                    color:Color(0xFFFFFFFF),
                                    fontSize: 20,
                                    fontFamily: 'Roboto',
                                  ),)
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      );
        },
        error:(err,stack){return Center(child:Text('some thing happened $err') ,);},
        loading:(){return Center(child: CircularProgressIndicator(strokeWidth: 3,));}
    );


    throw UnimplementedError();
  }
  
}

