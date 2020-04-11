import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/edit_repository_item_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/repo_filter_screen.dart';
import '../screens/test_screen.dart';
import '../screens/patients_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context);
    return auth.isMDT
        ? Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Text('Palliative Care App'),
                  automaticallyImplyLeading: false,
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(TabsScreen.routeName),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.healing),
                  title: Text('Patients'),
                  onTap: () =>
                      Navigator.of(context).pushNamed(PatientsScreen.routeName),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('edit'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushNamed(EditRepositoryItemScreen.routeName);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.of(context)
                        .pop(); //need to close drawer before logout, otherwise error
                    Navigator.of(context).pushReplacementNamed('/');
                    Provider.of<Auth>(context, listen: false).logout();
                  },
                ),
              ],
            ),
          )
        : Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Text('Palliative Care App'),
                  automaticallyImplyLeading: false,
                ),
                ListTile(
                  leading: Icon(Icons.library_books),
                  title: Text('Suggested Content'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routeName);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(RepoFilterScreen.routeName),
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
                    //need to close drawer before logout, otherwise error
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/');
                    Provider.of<Auth>(context, listen: false).logout();
                  },
                ),
              ],
            ),
          );
  }
}
