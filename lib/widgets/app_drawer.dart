import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/edit_repository_item_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/repo_filter_screen.dart';
import '../screens/test_screen.dart';

// import '../screens/my_home_page_screen.dart';
// import '../screens/oauth_test_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Palliative Care App'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Suggested Content'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(TabsScreen.routeName),
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.edit),
          //   title: Text('Community'),
          //   onTap: () => Navigator.of(context)
          //       .pushReplacementNamed(CommunityScreen.routeName),
          // ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(TestScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(RepoFilterScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('edit'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(EditRepositoryItemScreen.routeName),
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.lock),
          //   title: Text('Oauth'),
          //   onTap: () => Navigator.of(context)
          //       .pushReplacementNamed(OauthTestScreen.routeName),
          // ),
          // Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context)
                  .pop(); //need to close drawer before logout, otherwise error
              Provider.of<Auth>(context).logout();
            },
          ),
        ],
      ),
    );
  }
}
