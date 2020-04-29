import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
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

  @override
  Widget build(BuildContext context) {
    print('build repository_list');
    final repoProv = Provider.of<Repository>(context);
    final categories = repoProv.repositoryFilters;

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
              itemCount: repoProv.items
                  .where((item) => categories.keys
                      .where((element) => categories[element] == true)
                      .toList()
                      .contains(item.category))
                  .toList()
                  .length,
              itemBuilder: (_, i) => ChangeNotifierProvider.value(
                // value: repo.items[i],
                value: repoProv.items
                    .where((item) => categories.keys
                        .where((element) => categories[element] == true)
                        .toList()
                        .contains(item.category))
                    .toList()[i],
                child: RepositoryItem("nogroup"),
              ),
              separatorBuilder: (_, i) => const Divider(),
            ),
          ),
        ),
      ],
    );
  }
}
