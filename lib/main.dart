import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'model.dart';
import 'objectives.dart';
import 'tabs.dart';

void main() => runApp(VeloApp());

class VeloApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VeloModel>(
      builder: (context) => VeloModel(),
      child: MaterialApp(
        title: 'V€LO',
        theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.lime),
        home: Scaffolder(),
      ),
    );
  }
}

class Scaffolder extends StatefulWidget {
  @override
  _ScaffolderState createState() => _ScaffolderState();
}

class _ScaffolderState extends State<Scaffolder> {
  int _currentTab = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppTab mainWidget;
    if (_currentTab == 0) {
      mainWidget = HomePage();
    } else if (_currentTab == 1) {
      mainWidget = ObjectivePage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("V€LO"),
        elevation: 0.0,
      ),
      body: Consumer<VeloModel>(builder: (context, model, child) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return mainWidget;
      }),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentTab,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Accueil'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Objectifs'),
          ),
        ],
      ),
      floatingActionButton: mainWidget.getFloatingActionButton(context),
    );
  }
}
