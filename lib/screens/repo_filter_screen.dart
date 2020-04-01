import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/repository.dart';
import '../screens/tabs_screen.dart';


class RepoFilterScreen extends StatefulWidget {
  static const routeName = "/repo-filter-screen";
  // Map<String, bool> repoSettings = {
  //   'articles': true,
  //   'audio': true,
  //   'news': true,
  //   'stories': true,
  //   'videos': true,
  // };
  @override
  _RepoFilterScreenState createState() => _RepoFilterScreenState();
}

Map<String, bool> filters;

class _RepoFilterScreenState extends State<RepoFilterScreen> {
  Map<String, bool> repoSettings = {};

  var _articles = false;
  var _audio = false;
  var _news = false;
  var _stories = false;
  var _videos = false;

  var _isInit = true;
  // var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      repoSettings =
          Provider.of<Repository>(context, listen: false).repositoryFilters;
      _isInit = false;
      _articles = repoSettings['articles'];
      _audio = repoSettings['audio'];
      _news = repoSettings['news'];
      _stories = repoSettings['stories'];
      _videos = repoSettings['videos'];
    }
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  void saveFilters() {
    final selectedFilters = {
      'articles': _articles,
      'audio': _audio,
      'news': _news,
      'stories': _stories,
      'videos': _videos,
    };
    Provider.of<Repository>(context, listen: false).saveRepositoryFilters(selectedFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              saveFilters();
              Navigator.of(context).pushNamed(TabsScreen.routeName);
            },
          )
        ],
      ),
      // drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Please choose repository formats.',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Articles',
                  'Include Articles',
                  _articles,
                  (newValue) {
                    setState(
                      () {
                        _articles = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Audio',
                  'Include Audio',
                  _audio,
                  (newValue) {
                    setState(
                      () {
                        _audio = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'News',
                  'Include News',
                  _news,
                  (newValue) {
                    setState(
                      () {
                        _news = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Stories',
                  'Include Stories',
                  _stories,
                  (newValue) {
                    setState(
                      () {
                        _stories = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Videos',
                  'Include Videos',
                  _videos,
                  (newValue) {
                    setState(
                      () {
                        _videos = newValue;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
