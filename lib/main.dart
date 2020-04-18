import 'package:FlutterFYP/screens/admin_group_detail_screen.dart';
import 'package:FlutterFYP/screens/admin_read_groups_screen.dart';
import 'package:FlutterFYP/screens/edit_group_screen.dart';
import 'package:FlutterFYP/screens/edit_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/repository.dart';
import './providers/patients.dart';
import './screens/auth_screen.dart';
import './screens/share_with_patient_screen.dart';
import './screens/tabs_screen.dart';
import './screens/edit_repository_item_screen.dart';
import './screens/detailed_repo_item_screen.dart';
import './screens/patients_screen.dart';
import './screens/mdt_patient_screen.dart';
import './screens/splash_screen.dart';

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
              ? TabsScreen()
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
            DetailedRepoItemScreen.routeName: (ctx) => DetailedRepoItemScreen(),
            EditGroupScreen.routeName: (ctx) => EditGroupScreen(),
            EditRepositoryItemScreen.routeName: (ctx) =>
                EditRepositoryItemScreen(),
            TabsScreen.routeName: (ctx) => TabsScreen(),
            ShareWithPatientScreen.routeName: (ctx) => ShareWithPatientScreen(),
            PatientsScreen.routeName: (ctx) => PatientsScreen(),
            MdtPatientScreen.routeName: (ctx) => MdtPatientScreen(),
            AdminReadGroupsScreen.routeName: (ctx) => AdminReadGroupsScreen(),
            AdminGroupDetailScreen.routeName: (ctx) => AdminGroupDetailScreen(),
            EditUserScreen.routeName: (ctx) => EditUserScreen(),
          },
        ),
      ),
    );
  }
}
