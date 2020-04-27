import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/edit_repository_item_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/edit_group_screen.dart';
import '../screens/patients_screen.dart';
import '../screens/admin_read_groups_screen.dart';
import '../screens/admin_all_user_detailed_screen.dart';
import '../screens/edit_user_screen.dart';
import '../screens/test_provider_screen.dart';


class AppDrawer extends StatelessWidget {
  Widget _buildAdminDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Palliative Care App'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Repo Items'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(TabsScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Add Repo Item'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushNamed(EditRepositoryItemScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Users'),
            onTap: () => Navigator.of(context).pushNamed(
              AdminAllUserDetailedScreen.routeName,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text('Add User'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(EditUserScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Groups'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AdminReadGroupsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.group_add),
            title: Text('Add Group'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(EditGroupScreen.routeName);
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
    );
  }

  Widget _buildMdtDrawer(BuildContext context) {
    return Drawer(
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
            title: Text('Test Provider'),
            onTap: () =>
                Navigator.of(context).pushNamed(TestProviderScreen.routeName),
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
            title: Text('Add Repo Item'),
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
    );
  }

  Widget _buildPatientDrawer(BuildContext context) {
    return Drawer(
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
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => Navigator.of(context)
                .pushNamed(SettingsScreen.routeName),
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

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context, listen: false).isAdmin;
    final role = Provider.of<Auth>(context, listen: false).role ?? "";

    if (role.contains('ADMIN'))
      return _buildAdminDrawer(context);
    else if (role.contains('MDT'))
      return _buildMdtDrawer(context);
    else
      return _buildPatientDrawer(context);
    // return auth.isMDT
    //     ? Drawer(
    //         child: Column(
    //           children: <Widget>[
    //             AppBar(
    //               title: Text('Palliative Care App'),
    //               automaticallyImplyLeading: false,
    //             ),
    //             ListTile(
    //               leading: Icon(Icons.home),
    //               title: Text('Home'),
    //               onTap: () => Navigator.of(context)
    //                   .pushReplacementNamed(TabsScreen.routeName),
    //             ),
    //             Divider(),
    //             ListTile(
    //               leading: Icon(Icons.healing),
    //               title: Text('Patients'),
    //               onTap: () =>
    //                   Navigator.of(context).pushNamed(PatientsScreen.routeName),
    //             ),
    //             Divider(),
    //             ListTile(
    //               leading: Icon(Icons.edit),
    //               title: Text('Add Repo Item'),
    //               onTap: () {
    //                 Navigator.of(context).pop();
    //                 Navigator.of(context)
    //                     .pushNamed(EditRepositoryItemScreen.routeName);
    //               },
    //             ),
    //             Divider(),
    //             ListTile(
    //               leading: Icon(Icons.exit_to_app),
    //               title: Text('Logout'),
    //               onTap: () {
    //                 Navigator.of(context)
    //                     .pop(); //need to close drawer before logout, otherwise error
    //                 Navigator.of(context).pushReplacementNamed('/');
    //                 Provider.of<Auth>(context, listen: false).logout();
    //               },
    //             ),
    //           ],
    //         ),
    //       )
    //     : Drawer(
    //         child: Column(
    //           children: <Widget>[
    //             AppBar(
    //               title: Text('Palliative Care App'),
    //               automaticallyImplyLeading: false,
    //             ),
    //             ListTile(
    //               leading: Icon(Icons.library_books),
    //               title: Text('Suggested Content'),
    //               onTap: () {
    //                 Navigator.of(context).pop();
    //                 Navigator.of(context)
    //                     .pushReplacementNamed(TabsScreen.routeName);
    //               },
    //             ),
    //             Divider(),
    //             ListTile(
    //               leading: Icon(Icons.settings),
    //               title: Text('Settings'),
    //               onTap: () => Navigator.of(context)
    //                   .pushReplacementNamed(RepoFilterScreen.routeName),
    //             ),
    //             Divider(),
    //             // ListTile(
    //             //   leading: Icon(Icons.lock),
    //             //   title: Text('Oauth'),
    //             //   onTap: () => Navigator.of(context)
    //             //       .pushReplacementNamed(OauthTestScreen.routeName),
    //             // ),
    //             // Divider(),
    //             ListTile(
    //               leading: Icon(Icons.exit_to_app),
    //               title: Text('Logout'),
    //               onTap: () {
    //                 //need to close drawer before logout, otherwise error
    //                 Navigator.of(context).pop();
    //                 Navigator.of(context).pushReplacementNamed('/');
    //                 Provider.of<Auth>(context, listen: false).logout();
    //               },
    //             ),
    //           ],
    //         ),
    //       );
  }
}
