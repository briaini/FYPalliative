import 'package:FlutterFYP/widgets/my_tab_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './test_screen.dart';

class AdminUserOverviewScreen extends StatefulWidget {
  static const routeName = '/admin-user-overview-screen';

  @override
  _AdminUserOverviewScreenState createState() =>
      _AdminUserOverviewScreenState();
}

class _AdminUserOverviewScreenState extends State<AdminUserOverviewScreen> {
  final categories = {
    'All': true,
    'Excercise': true,
    'Pain': true,
    'Stress': true
  };
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('User Overview'),
          ),
          body: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    boxShadow: kElevationToShadow[3]),
                height: 25,
                // color: Theme.of(context).primaryColor,
                child: Row(
                    children: categories.keys
                        .map((category) => GestureDetector(
                              child: Container(
                                child: Text(
                                  category,
                                  textAlign: TextAlign.center,
                                ),
                                decoration: BoxDecoration(
                                    color: categories[category]
                                        ? Theme.of(context).accentColor
                                        : Theme.of(context).primaryColorLight,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: kElevationToShadow[1]),
                                height: 20,
                                width: 75,
                              ),
                              onTap: () {
                                setState(() {
                                  if (category.contains('All')) {
                                    categories[category] =
                                        !categories[category];
                                    categories.updateAll((key, value) =>
                                        categories[key] = categories[category]);
                                  } else
                                    categories['$category'] =
                                        !categories['$category'];
                                    if(categories.values.elementAt(0)==false && categories.values.where((val) => val==false).length == 1)
                                      categories['All'] = true;
                                    else if (categories.containsValue(false))
                                      categories['All'] = false;
                                });
                                print(categories['$category']);
                              },
                            ))
                        .toList()),
              ),
              Text('hi')
            ],
          )),
    );
  }
}
