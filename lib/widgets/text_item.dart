import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item.dart';
import './comments_list.dart';

class TextItem extends StatelessWidget {
  final hasComments;
  
  TextItem(this.hasComments);

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
          ),
          item.imageUrl != null
              ? Container(
                  width: double.infinity,
                  height: 250,
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
          Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(item.title, textAlign: TextAlign.center,),
              SizedBox(
                height: 10,
              ),
              Text(item.description, textAlign: TextAlign.justify, ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
          hasComments ? CommentsList() : Container(),
          // Expanded(
          //   child: CommentsList(),
          // ),
        ],
      ),
    );
  }
}
