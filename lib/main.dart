import 'package:FlutterFYP/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/repository.dart';
import './screens/tabs_screen.dart';
import './screens/splash_screen.dart';
import './screens/edit_repository_item_screen.dart';
import './screens/detailed_repo_item_screen.dart';

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
            // previousRepoItems == null ? [] : previousRepoItems.items,
          ),
        ),
        // ChangeNotifierProxyProvider<Auth, Item>(
        //   builder: (ctx, auth, previousItems) => Item(
        //     auth.token,
        //     auth.userId,
        //   ),
        // ),
        // ChangeNotifierProxyProvider<Auth, Item>(
        //   builder: (ctx, auth, previousItems) => Item(
        //     auth.token,
        //     auth.userId,
        //   ),
        // ),

        // ChangeNotifierProvider.value(
        //   value: Item(),
        // ),
        // ChangeNotifierProxyProvider<Auth, Orders>(
        //   builder: (ctx, auth, previousOrders) => Orders(
        //     auth.token,
        //     auth.userId,
        //     previousOrders == null ? [] : previousOrders.orders,
        //   ),
        // )
      ],
      // return ChangeNotifierProvider.value(  //.value should be used in list or grid
      //   value: Products(),
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? TabsScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            DetailedRepoItemScreen.routeName: (ctx) => DetailedRepoItemScreen(),
            EditRepositoryItemScreen.routeName: (ctx) =>
                EditRepositoryItemScreen(),
            TabsScreen.routeName: (ctx) => TabsScreen(),
          },
        ),
      ),
    );
  }
}
