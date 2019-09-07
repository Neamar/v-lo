import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'model.dart';

void main() => runApp(VeloApp());

class VeloApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V€LO',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.red,
          accentColor: Colors.lime),
      home: Scaffolder(),
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
    Widget mainWidget;
    if (_currentTab == 0) {
      mainWidget = HomePage();
    } else if (_currentTab == 1) {
      mainWidget = Container(color: Colors.purpleAccent);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("V€LO"),
        elevation: 0.0,
      ),
      body: ChangeNotifierProvider(
        builder: (context) => VeloModel(),
        child: Consumer<VeloModel>(builder: (context, model, child) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return mainWidget;
        }),
      ),
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
    );
  }
}
