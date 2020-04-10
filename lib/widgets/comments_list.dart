import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/repository.dart';
import '../providers/item.dart';
import '../providers/group.dart';
import './comment_item.dart';

class CommentsList extends StatefulWidget {

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  var _isInit = true;
  var _isLoading = false;

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(
  //       () {
  //         _isLoading = true;
  //       },
  //     );

  //     Provider.of<Item>(context).fetchCommments(widget._item.id).then(
  //       (_) {
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       },
  //     );
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  void saveComment(comment) {
    Provider.of<Repository>(context).saveComment(comment);
  }


  @override
  Widget build(BuildContext context) {
    final group = Provider.of<Group>(context);
    
     final comments = group.comments ?? [];

    // print('_' + widget._item.comments.toString());
    //    print('jsonMap' + widget._item.comments.toString());

    // final product =
    //     Provider.of<Item>(context, listen: false);

    // var items = Provider.of<Items>(context, listen:false);
    // var _comments = items.comments;

    // final repo = Provider.of<Repository>(context, listen: false);

    // return _comments != null
    // ?
    // GestureDetector(
    //     onLongPress: () {
    //       setState(
    //         () {
    //           _replyBranchForm = !_replyBranchForm;
    //         },
    //       );
    //     },
    // child:
    // Consumer<Product>(
    //     builder: (ctx, product, child) => IconButton(
    //       icon: Icon(
    //           product.isFavorite ? Icons.favorite : Icons.favorite_border),
    //       color: Theme.of(context).accentColor,
    //       onPressed: () {
    //         product.toggleFavoriteStatus(authData.token, authData.userId);
    //       },
    //     ),
    //     // child: , //can be used to add widget that doesn't update in consumer
    //   ),
    return Column(
      children: <Widget>[
        ExpansionTile(
          leading: Icon(Icons.comment),
          title: Text('Comments (${comments.length})'),
          children: List<Widget>.generate(
            comments.length,
            (i) {
              return Column(
                children: <Widget>[
                  CommentItem(comments[i]),
                  Divider(
                    height: 8,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
