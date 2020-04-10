import 'package:FlutterFYP/screens/share_with_patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/item.dart';
import '../widgets/text_item_web_view.dart';
import '../widgets/text_item.dart';

class TextItemTabScreen extends StatefulWidget {
  final hasComments;

  TextItemTabScreen(this.hasComments);

  @override
  _TextItemTabScreen createState() => _TextItemTabScreen();
}

class _TextItemTabScreen extends State<TextItemTabScreen> {
  // void _goToShareWithPatientPage() {
  //   Navigator.of(context).pushNamed(
  //     ShareWithPatientScreen.routeName,
  //     arguments: widget.item.id,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final item = Provider.of<Item>(context, listen: false);


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: auth.isMDT
              ? <Widget>[
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: null
                    // _goToShareWithPatientPage,
                  )
                ]
              : null,
          title: Text(item.title),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.message),
              ),
              Tab(
                icon: Icon(Icons.link),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TextItem(widget.hasComments),
            TextItemWebView(),
            // TextItem(widget.item),
          ],
        ),
      ),
    );
  }
}
