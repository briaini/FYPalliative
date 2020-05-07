import 'package:FlutterFYP/screens/patients_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/repository.dart';
import './repository_screen.dart';
import './community_screen.dart';
import './profile_screen.dart';
import '../widgets/app_drawer.dart';
import '../screens/mdt_other_groups_screen.dart';

enum FilterOptions {
  Category,
  Title,
  Media,
}

class TabsScreen extends StatefulWidget {
  static const routeName = 'tabs-screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  var _pages = [];
  void _selectPage(int index) {
    //automatically receives index of tab page
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMdt = Provider.of<Auth>(context).isMDT;
    _pages = isMdt
        ? [
            {
              'page': RepositoryScreen(),
              'title': 'Repository',
            },
            {
              'page': PatientsScreen(),
              'title': 'Patients',
            },
            {
              'page': MdtOtherGroupsScreen(),
              'title': 'Social',
            },
          ]
        : [
            {
              'page': RepositoryScreen(),
              'title': 'Repository',
            },
            {
              'page': CommunityScreen(),
              'title': 'Community',
            },
            {
              'page': ProfileScreen(),
              'title': 'Profile',
            },
          ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        actions: <Widget>[PopupMenuButton(
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
                ),],
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
              title: Text(isMdt ? 'Patients' : 'Community'),
              icon: Icon(isMdt ? Icons.healing : Icons.people),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              title: Text(isMdt ? 'Social' : 'Profile'),
              icon: Icon(isMdt ? Icons.people : Icons.person),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ]),
    );
  }
}
