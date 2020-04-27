import 'package:FlutterFYP/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';

class TestProviderScreen extends StatefulWidget {
  static const routeName = '/test-provider-screen';
  @override
  _TestProviderScreenState createState() => _TestProviderScreenState();
}

class _TestProviderScreenState extends State<TestProviderScreen> {
  @override
  Widget build(BuildContext context) {
    print('building');
    final prov = Provider.of<Patients>(context);

    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Text(prov.getTest),
          FlatButton(
            onPressed: () => setState(() {
              prov.editString('changed');
            }),
            child: Text('Clickme'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: prov.testArray.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(prov.testArray[i]),
              ),
            ),
          ),
          FlatButton(
            onPressed: () => setState(() {
              prov.addToTestArray("newTile");
            }),
            child: Text("Add to array"),
          ),
        ],
      ),
    );
  }
}
