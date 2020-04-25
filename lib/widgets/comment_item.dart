import 'package:flutter/material.dart';

import '../providers/comment.dart';

class CommentItem extends StatefulWidget {
  Comment _comment;

  CommentItem(this._comment);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  var _replyButton = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 20,
                      backgroundImage:
                          AssetImage('assets/images/usertile16.bmp'),
                    ),
                    Text(
                      'Name=${widget._comment.subjectId.toString()}',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              children: <Widget>[
                Text(widget._comment.textBody),
              ],
            ),
          ],
        ),
      ),
    );

    // ListTile(
    //   leading: Chip(
    //     label: Text(
    //       'Name=${widget._comment.subjectId.toString()}',
    //     ),
    //     // padding: EdgeInsets.all(10),
    //     avatar: Container(
    //       child: CircleAvatar(
    //         backgroundImage: AssetImage('assets/images/usertile16.bmp'),
    //       ),
    //     ),
    //   ),
    //   title: Text(widget._comment.textBody),
    // ),

    // GestureDetector(
    //   child: Container(
    //     // width: double.infinity,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: <Widget>[
    //             // CircleAvatar(
    //             //   backgroundImage: NetworkImage(
    //             //     widget._comment.imageUrl,
    //             //   ),
    //             // // ),
    //             // SizedBox(width: 5),
    //             // Text(widget._comment.authorName),
    //           ],
    //         ),
    //         Text(
    //           widget._comment.textBody,
    //           textAlign: TextAlign.left,
    //         ),
    //         _replyButton
    //             ? FlatButton(
    //                 onPressed: () {},
    //                 child: Text('Reply'),
    //               )
    //             : Container(),
    //       ],
    //     ),
    //   ),
    //   onLongPress: () {
    //     setState(() {
    //       _replyButton = !_replyButton;
    //     });
    //   },
    // );

    // key: ValueKey()
    //   width: double.infinity,
    //   child: Row(
    //     children: <Widget>[
    //       Expanded(
    //         flex: 1,
    //         child: CircleAvatar(
    //           backgroundImage: NetworkImage(
    //             _comment.imageUrl,
    //             // fit: null,
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //         flex: 3,
    //         child: Padding(
    //           padding: const EdgeInsets.all(4.0),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Text(
    //                 _comment.text,
    //                 // style: nameTheme,
    //               ),
    //               // SizedBox(height: 2.0),
    //               // Text(userData.email, style: emailTheme),
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
