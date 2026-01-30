
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';

import '../../models/Post.dart';

class Postcard extends StatefulWidget {
  final Post? post;
  const Postcard(this.post, {super.key});

  @override
  State<Postcard> createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {
  bool showDesc=false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      margin: EdgeInsets.only(top:10,bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 450,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child:widget.post!.account!.profilePic!.contains('.avif')? AvifImage.network(
                            '${widget.post?.account?.profilePic}',
                            width: 30,
                            height: 30,
                            fit:BoxFit.cover,
                          ): Image.network(
                            '${widget.post?.account?.profilePic}',
                            width: 30,
                            height: 30,
                            fit:BoxFit.cover,
                          ),
                        ),
                      ),
                      // Text("first",
                      //   style: TextStyle(
                      //     color: Color(0xFFFFFFFF),
                      //   ),),
                      SizedBox(width: 20,),

                      Text('${widget.post?.account?.name}',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          ),),

                    ],
                  ),

                IconButton(
                    onPressed:(){},
                    icon:ImageIcon(
                      AssetImage('asset/images/More_vertical.png'),
                      size: 30,
                      color: Color(0XFFFFFFFF),
                    ))
              ],
            ),
          ),
          Expanded(child:Container(
            color: Color(0xFFFFFFFF),
            child: PageView(
              scrollDirection: Axis.horizontal,
              children: [

                  for(int i=0;i<widget.post!.media!.length;i++)
                  Image.network(
                    '${widget.post!.media?[i].mediaUrl}',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image, color: Colors.grey, size: 50),
                            Text('Image failed to load'),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            )

          ) ),
          Padding(
            padding: EdgeInsets.all(5),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed:(){},
                        icon:ImageIcon(
                          AssetImage('asset/images/Heart.png'),
                          size: 23,
                          color: Color(0XFFFFFFFF),
                        )),
                    SizedBox(width: 20,),
                    IconButton(
                        onPressed:(){},
                        icon:ImageIcon(
                          AssetImage('asset/images/chat_bubble.png'),
                          size: 30,
                          color: Color(0XFFFFFFFF),

                        )),
                  ],
                ),
                IconButton(
                    onPressed:(){},
                    icon:ImageIcon(
                      AssetImage('asset/images/bookmark.png'),
                      size: 40,
                      color: Color(0XFFFFFFFF),
                    )),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(10,0,10,10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[ Expanded(
              child: Text(
                '${widget.post!.description??""}',
                maxLines: showDesc ? null : 1,
                overflow: showDesc ? TextOverflow.visible : TextOverflow.ellipsis,
                style:TextStyle(
                  fontSize:16,
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 0.1,),
                ),
            ),
             TextButton(onPressed: (){
               setState(()=>showDesc=!showDesc);
             },
                 child:Text(showDesc?'less':'more',
                   style: TextStyle(
                     color: Color(0xFFD6CFCE),
                   ),
                 ))
            ]
          ),
          )
        ],
      ),
    );
    throw UnimplementedError();
  }
}