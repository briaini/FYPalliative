import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/repository.dart';
import './admin_all_user_detailed_screen.dart';
import './admin_tabs_groups_screen.dart';
import './edit_repository_item_screen.dart';
import './edit_user_screen.dart';
import './edit_group_screen.dart';
import './repository_screen.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  Category,
  Title,
  Media,
}

class AdminTabsScreen extends StatefulWidget {
  static const routeName = '/admin-tabs-screen';
  @override
  _AdminTabsScreenState createState() => _AdminTabsScreenState();
}

class _AdminTabsScreenState extends State<AdminTabsScreen> {
  int _selectedPageIndex = 0;
  final _pages = [
    {
      'page': RepositoryScreen(),
      'title': 'Repository',
    },
    {
      'page': AdminAllUserDetailedScreen(),
      'title': 'Users',
    },
    {
      'page': AdminTabsGroupsScreen(),
      'title': 'Groups',
    },
  ];

  void _selectPage(int index) {
    //automatically receives index of tab page
    setState(() {
      _selectedPageIndex = index;
    });
  }

  FilterOptions fo = FilterOptions.Title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          _selectedPageIndex != 0
              ? Container()
              : PopupMenuButton(
                  onSelected: (FilterOptions selectedValue) {
                    setState(
                      () {
                        if (selectedValue == FilterOptions.Category) {
                          Provider.of<Repository>(context)
                              .setFilterOptions(FilterOptions.Category);
                        } else if (selectedValue == FilterOptions.Media) {
                          Provider.of<Repository>(context)
                              .setFilterOptions(FilterOptions.Media);
                        } else {
                          Provider.of<Repository>(context)
                              .setFilterOptions(FilterOptions.Title);
                        }
                      },
                    );
                  },
                  icon: Icon(Icons.sort),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Category'),
                      value: FilterOptions.Category,
                    ),
                    PopupMenuItem(
                      child: Text('Media'),
                      value: FilterOptions.Media,
                    ),
                    PopupMenuItem(
                      child: Text('Title'),
                      value: FilterOptions.Title,
                    ),
                  ],
                ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                switch (_selectedPageIndex) {
                  case 0:
                    {
                      Navigator.of(context)
                          .pushNamed(EditRepositoryItemScreen.routeName);
                    }
                    break;
                  case 1:
                    {
                      Navigator.of(context).pushNamed(EditUserScreen.routeName);
                    }
                    break;
                  case 2:
                    {
                      Navigator.of(context)
                          .pushNamed(EditGroupScreen.routeName);
                    }
                    break;
                  default:
                }
              }),
        ],
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: AppDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).unselectedWidgetColor,
          selectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              title: Text('Repo'),
              icon: Icon(Icons.folder),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              title: Text('Users'),
              icon: Icon(Icons.person),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              title: Text('Groups'),
              icon: Icon(Icons.people),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ]),
    );
  }
}
