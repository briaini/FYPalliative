import 'package:flutter/material.dart';

class CommentItem extends StatefulWidget {
  final _comment;

  CommentItem(this._comment);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  var _replyButton = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        // width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // CircleAvatar(
                //   backgroundImage: NetworkImage(
                //     widget._comment.imageUrl,
                //   ),
                // // ),
                // SizedBox(width: 5),
                // Text(widget._comment.authorName),
              ],
            ),
            Text(
              widget._comment.textBody,
              textAlign: TextAlign.left,
            ),
            _replyButton
                ? FlatButton(
                    onPressed: () {},
                    child: Text('Reply'),
                  )
                : Container(),
          ],
        ),
      ),
      onLongPress: () {
        setState(() {
          _replyButton = !_replyButton;
        });
      },
    );
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
