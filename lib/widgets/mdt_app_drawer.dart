import 'package:FlutterFYP/screens/auth_screen.dart';
import 'package:FlutterFYP/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/edit_repository_item_screen.dart';

class MdtAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Palliative Care App'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('edit'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(EditRepositoryItemScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(TabsScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Provider.of<Auth>(context).logout();
              Navigator.of(context)
                  .pop(); //need to close drawer before logout, otherwise error
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen:false).logout();
            },
          ),
        ],
      ),
    );
  }
}
