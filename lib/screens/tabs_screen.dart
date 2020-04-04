import 'package:flutter/material.dart';

import './repository_screen.dart';
import './community_screen.dart';
import './profile_screen.dart';
import '../widgets/app_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = 'tabs-screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final _pages = [
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
  // List<Map<String, Object>> _pages;
  // @override
  // void initState() {
  //   _pages = [
  //     {
  //       'page': RepositoryScreen(),
  //       'title': 'Repository',
  //     },
  //     {
  //       'page': CommunityScreen(),
  //       'title': 'Community',
  //     },
  //     {
  //       'page': ProfileScreen(),
  //       'title': 'Profile',
  //     },
  //   ];
  //   super.initState();
  // }

  void _selectPage(int index) {
    //automatically receives index of tab page
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: AppDrawer(),
      body: 
      _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.limeAccent,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              title: Text('Repo'),
              icon: Icon(Icons.library_books),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              title: Text('Community'),
              icon: Icon(Icons.people),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              title: Text('Profile'),
              icon: Icon(Icons.person),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ]),
    );
  }
}
