import 'package:FlutterFYP/screens/admin_tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/item.dart';
import './repository_item.dart';
import '../providers/repository.dart';

class RepositoryList extends StatefulWidget {
  @override
  _RepositoryListState createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {
  var _isInit = true;
  var _isLoading = false;

  // final categories = {
  //   'All': true,
  //   'Excercise': true,
  //   'Pain': true,
  //   'Stress': true
  // };

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {

  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final repoProv = Provider.of<Repository>(context);
    final categories = repoProv.repositoryFilters;
    final isAdmin = Provider.of<Auth>(context, listen: false).isAdmin;

    // final localItems = Provider.of<Repository>(context).items
    //     .where((item) => categories.keys
    //         .where((element) => categories[element] == true)
    //         .toList()
    //         .contains(item.category))
    //     .toList()..sort((a,b)=> a.title.compareTo(b.title));

    final test = Provider.of<Repository>(context).filterOptions;

    List<Item> localItems = [];

    switch (test) {
      case FilterOptions.Title:
        localItems = Provider.of<Repository>(context)
            .items
            .where((item) => categories.keys
                .where((element) => categories[element] == true)
                .toList()
                .contains(item.category))
            .toList()
              ..sort((a, b) => a.title.compareTo(b.title));
        break;
        case FilterOptions.Media:
        localItems = Provider.of<Repository>(context)
            .items
            .where((item) => categories.keys
                .where((element) => categories[element] == true)
                .toList()
                .contains(item.category))
            .toList()
              ..sort((a, b) => a.media.compareTo(b.media));
        break;
        case FilterOptions.Category:
        localItems = Provider.of<Repository>(context)
            .items
            .where((item) => categories.keys
                .where((element) => categories[element] == true)
                .toList()
                .contains(item.category))
            .toList()
              ..sort((a, b) => a.category.compareTo(b.category));
        break;
      default:
    }

    // final localItems = Provider.of<Repository>(context)
    //     .items
    //     .where((item) => categories.keys
    //         .where((element) => categories[element] == true)
    //         .toList()
    //         .contains(item.category))
    //     .toList()
    //       ..sort((a, b) => a.title.compareTo(b.title));

    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: kElevationToShadow[3]),
          height: 25,
          // color: Theme.of(context).primaryColor,
          child: ListView(
            scrollDirection: Axis.horizontal,
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
                            categories[category] = !categories[category];
                            categories.updateAll((key, value) =>
                                categories[key] = categories[category]);
                          } else
                            categories['$category'] = !categories['$category'];
                          if (categories.values.elementAt(0) == false &&
                              categories.values
                                      .where((val) => val == false)
                                      .length ==
                                  1)
                            categories['All'] = true;
                          else if (categories.containsValue(false))
                            categories['All'] = false;
                          Provider.of<Repository>(context)
                              .saveRepositoryFilters(categories);
                        });
                      },
                    ))
                .toList(),
          ),
        ),
        Expanded(
          child: Container(
            child: ListView.separated(
              itemCount: localItems.length,
              itemBuilder: (_, i) => ChangeNotifierProvider.value(
                // value: repo.items[i],
                value: localItems[i],
                child: isAdmin
                    ? Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Theme.of(context).errorColor,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 4,
                          ),
                          child:
                              Icon(Icons.delete, color: Colors.white, size: 40),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          Provider.of<Repository>(context)
                              .deletePost(localItems[i].id);
                          // Navigator.of(context).pop();

                          Provider.of<Repository>(context)
                              .fetchItems()
                              .then((_) {
                            setState(() {
                              // _isLoading = false;
                            });
                          });
                          // );
                          // Provider.of<Repository>(context)
                          //     .fetchItems()
                          //     .then((_) => setState(() {}));
                          // localItems.(i);
                        },
                        confirmDismiss: (direction) {
                          return showDialog(
                            //returning showDialog returns Future for us
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('Are you sure?'),
                              content: Text('Do you want to delete repo item?'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.of(ctx).pop(false);
                                  },
                                ),
                                FlatButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    Navigator.of(ctx).pop(true);
                                  },
                                ),
                              ],
                            ),
                          );
                          // return Future.value(true);
                        },
                        child: RepositoryItem("nogroup"))
                    : RepositoryItem("nogroup"),
              ),
              separatorBuilder: (_, i) => const Divider(),
            ),
          ),
        ),
      ],
    );
  }
}
