import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class Objective {
  int category;
  String name;
  int price;

  Objective(this.category, this.name, this.price);
}

class _HomePageState extends State<HomePage> {
  double _moneySaved = 0;
  int _numberOfTrips = 5;
  Objective _currentObjective = Objective(0, "Casque de vélo", 3500);

  void _addMoney(int value) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _moneySaved += value;
      _numberOfTrips++;
    });
  }

  String _getMoneySavedInEuros() {
    return (_moneySaved / 100).toStringAsFixed(2);
  }

  String _getTotalMoneySavedInEuros() {
    String r = ((_moneySaved + 550) / 100).round().toString();
    return r;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.directions_bike,
                size: 120,
              ),
              Text(
                _currentObjective.name,
              ),
              Text(
                _getMoneySavedInEuros().toString() + "€",
                style: Theme.of(context).textTheme.display1,
              ),
              new LinearPercentIndicator(
                lineHeight: 5.0,
                percent: _moneySaved / _currentObjective.price,
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GlobalStats("Total économisé", _getTotalMoneySavedInEuros() + "€"),
                  GlobalStats("Trajets effectués", _numberOfTrips.toString()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addMoney(190),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class GlobalStats extends StatelessWidget {
  String name;
  String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(name),
        Text(
          value,
          style: Theme.of(context).textTheme.display2,
        ),
      ],
    )
  }

  GlobalStats(String this.name, String this.value);
}