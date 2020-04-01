import 'package:FlutterFYP/providers/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/repository.dart';


class TestScreen extends StatelessWidget {

  static const routeName = "/test-screen";
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final repo = Provider.of<Repository>(context,listen: false);
    repo.fetchItems();
    // auth.authenticate("brian", "password");

    return Scaffold(
      body: Center(
        child: Text("toekn:\n${auth.token}\n\n" +
            "userId:\n${auth.userId} \n\n" +
            "_expiryDate\n${auth.expiryDate.toString()}\n\n" +
            "_authTimer:\n${auth.authTimer.toString()}\n\n"),
      ),
    );
  }
}
