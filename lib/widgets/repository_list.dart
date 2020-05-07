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
    var localfilters = repoProv.repositoryFilters.keys.toList();
    localfilters.sort((a, b) => a.compareTo(b));
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
              children: List<Widget>.generate(
                  localfilters.length,
                  (i) => InkWell(
                        // highlightElevation: 12,
                        // focusNode: Focu,
                        child: GestureDetector(
                          // color: Colors.white,

                          onTap: () {
                            setState(() {
                              if (localfilters[i].contains('All')) {
                                categories[localfilters[i]] =
                                    !categories[localfilters[i]];
                                categories.updateAll((key, value) =>
                                    categories[key] =
                                        categories[localfilters[i]]);
                              } else
                                categories[localfilters[i]] =
                                    !categories[localfilters[i]];
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
                          // disabledBorderColor: Colors.white,
                          // disabledTextColor: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.8),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: Colors.black38,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Text(
                              localfilters[i],
                              style: TextStyle(
                                color: categories[localfilters[i]]
                                    ? Colors.white
                                    : Colors.black45,
                              ),
                            ),
                            // decoration: BoxDecoration(
                            //   color: categories[localfilters[i]]
                            //       ? Theme.of(context).primaryColor
                            //       : Colors.blueGrey,
                            // ),

                            // color: Colors.white,
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                        ),
                      ))

              // localfilters
              //     .map(
              //       (category) => InkWell(
              //         // highlightElevation: 12,
              //         // focusNode: Focu,
              //         child: GestureDetector(
              //           // color: Colors.white,

              //           onTap: () {
              //             setState(() {
              //               if (category.contains('All')) {
              //                 categories[category] = !categories[category];
              //                 categories.updateAll((key, value) =>
              //                     categories[key] = categories[category]);
              //               } else
              //                 categories['$category'] = !categories['$category'];
              //               if (categories.values.elementAt(0) == false &&
              //                   categories.values
              //                           .where((val) => val == false)
              //                           .length ==
              //                       1)
              //                 categories['All'] = true;
              //               else if (categories.containsValue(false))
              //                 categories['All'] = false;
              //               Provider.of<Repository>(context)
              //                   .saveRepositoryFilters(categories);
              //             });
              //           },
              //           // disabledBorderColor: Colors.white,
              //           // disabledTextColor: Colors.white,
              //           child: Chip(
              //             label: Text(category),
              //             backgroundColor: Colors.white,
              //             // color: Colors.white,
              //             padding: EdgeInsets.all(10),
              //           ),
              //         ),
              //       ),
              //     )
              //     .toList(),

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
                          Provider.of<Repository>(context).fetchItems();
                          // Navigator.of(context).pop();

                          // Provider.of<Repository>(context)
                          //     .fetchItems()
                          //     .then((_) {
                          setState(() {
                            // _isLoading = false;
                          });
                          // }
                          // );
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
