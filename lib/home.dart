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
  static const double ICON_SIZE = 80;
  static const radius = Radius.circular(ICON_SIZE);

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
    return Center(
      child: Column(
        children: <Widget>[
          Material(
            elevation: 8.0,
            child: Container(
              color: Colors.red,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: radius,
                            topRight: radius,
                            bottomLeft: radius,
                            bottomRight: radius)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.directions_bike,
                        size: ICON_SIZE,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  Text(
                    _currentObjective.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    _getMoneySavedInEuros().toString() + "€",
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .apply(color: Colors.white),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 23, vertical: 8),
                    child: LinearPercentIndicator(
                      lineHeight: 9.0,
                      percent: _moneySaved / _currentObjective.price,
                      backgroundColor: Colors.white,
                      progressColor: Theme.of(context).accentColor,
                      animation: true,
                      animationDuration: 500,
                      animateFromLastPercent: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GlobalStats(
                    "Total économisé", _getTotalMoneySavedInEuros() + "€"),
                GlobalStats("Trajets effectués", _numberOfTrips.toString()),
              ],
            ),
          )
        ],
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
    );
  }

  GlobalStats(String this.name, String this.value);
}
