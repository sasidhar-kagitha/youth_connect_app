
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youth_connect/pages/home/PostCard.dart';
import 'package:youth_connect/providers/future_provider.dart';

class Userposts  extends ConsumerWidget{
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // TODO: implement build
    final posts = ref.watch(getPostsByAccount);
    return posts.when(data:(posts){
        return posts?.length==0
            ?Center(child: Text("No posts",style: TextStyle(color: Color(0xFFFFFFFF),fontSize: 24),))
            :ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return Postcard(posts![index]);
          },
        );
        },
        error:(err,stack)=>Text("something went wrong $err"),
        loading:()=>Center(child: CircularProgressIndicator(strokeWidth: 4,),));
    throw UnimplementedError();
  }

}