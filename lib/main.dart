import 'package:FlutterFYP/screens/admin_group_detail_screen.dart';
import 'package:FlutterFYP/screens/admin_read_groups_screen.dart';
import 'package:FlutterFYP/screens/admin_tabs_screen.dart';
import 'package:FlutterFYP/screens/edit_group_screen.dart';
import 'package:FlutterFYP/screens/edit_user_screen.dart';
import 'package:FlutterFYP/screens/mdt_other_groups_screen.dart';
import 'package:FlutterFYP/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/repository.dart';
import './providers/patients.dart';
import './screens/admin_share_post_screen.dart';
import './screens/admin_all_posts_screen.dart';
import './screens/admin_all_users_add_screen.dart';
import './screens/admin_all_user_detailed_screen.dart';
import './screens/admin_user_overview_screen.dart';
import './screens/auth_screen.dart';
import './screens/share_with_patient_screen.dart';
import './screens/tabs_screen.dart';
import './screens/edit_repository_item_screen.dart';
import './screens/detailed_repo_item_screen.dart';
import './screens/patients_screen.dart';
import './screens/mdt_patient_screen.dart';
import './screens/mdt_all_posts_add_screen.dart';
import './screens/splash_screen.dart';
import './screens/test_provider_screen.dart';
import './screens/no_group_user_screen.dart';
import './screens/admin_tabs_groups_screen.dart';
import './screens/non_mdt_group_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        //Parent provider (Auth in this case) needs to come before dependent proxy provider
        ChangeNotifierProxyProvider<Auth, Repository>(
          builder: (ctx, auth, previousRepoItems) => Repository(
            auth.token,
            auth.userId,
            auth.username,
            auth.isMDT,
            previousRepoItems == null ? [] : previousRepoItems.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Patients>(
          builder: (ctx, auth, previousPatients) => Patients(
              auth.token,
              auth.userId,
              previousPatients == null ? [] : previousPatients.patients),
        ),
        // ChangeNotifierProxyProvider<Auth, Patient>(
        //   builder: (ctx, auth, previousItems) => Patient(
        //     auth.token,
        //     auth.userId,
        //   ),
        // ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Palliative',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.indigoAccent,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? (auth.isAdmin ? AdminTabsScreen() : TabsScreen())
              :
              //  AuthScreen(),
              FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            AdminSharePostScreen.routeName: (ctx) => AdminSharePostScreen(),
            AdminTabsScreen.routeName: (ctx) => AdminTabsScreen(),
            AdminTabsGroupsScreen.routeName: (ctx) => AdminTabsGroupsScreen(),
            NoGroupUserScreen.routeName: (ctx) => NoGroupUserScreen(),
            TestProviderScreen.routeName: (ctx) => TestProviderScreen(),
            AdminAllUsersAddScreen.routeName: (ctx) => AdminAllUsersAddScreen(),
            AdminAllUserDetailedScreen.routeName: (ctx) =>
                AdminAllUserDetailedScreen(),
            AdminAllPostsScreen.routeName: (ctx) => AdminAllPostsScreen(),
            AdminUserOverviewScreen.routeName: (ctx) =>
                AdminUserOverviewScreen(),
            DetailedRepoItemScreen.routeName: (ctx) => DetailedRepoItemScreen(),
            EditGroupScreen.routeName: (ctx) => EditGroupScreen(),
            EditRepositoryItemScreen.routeName: (ctx) =>
                EditRepositoryItemScreen(),
            TabsScreen.routeName: (ctx) => TabsScreen(),
            ShareWithPatientScreen.routeName: (ctx) => ShareWithPatientScreen(),
            PatientsScreen.routeName: (ctx) => PatientsScreen(),
            MdtPatientScreen.routeName: (ctx) => MdtPatientScreen(),
            MdtAllPostsAddScreen.routeName: (ctx) => MdtAllPostsAddScreen(),
            AdminReadGroupsScreen.routeName: (ctx) => AdminReadGroupsScreen(),
            AdminGroupDetailScreen.routeName: (ctx) => AdminGroupDetailScreen(),
            MdtOtherGroupsScreen.routeName: (ctx) => MdtOtherGroupsScreen(),
            NonMdtGroupOverviewScreen.routeName: (ctx) => NonMdtGroupOverviewScreen(),
            EditUserScreen.routeName: (ctx) => EditUserScreen(),
            SettingsScreen.routeName: (ctx) => SettingsScreen(),
            InfoWidget.routeName: (ctx) => InfoWidget(),
          },
        ),
      ),
    );
  }
}
