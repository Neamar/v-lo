import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class HomePage extends StatelessWidget {
  static const double ICON_SIZE = 80;
  static const radius = Radius.circular(ICON_SIZE);
  String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          new Stack(
            overflow: Overflow.visible,
            alignment: new FractionalOffset(.5, 1.0),
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                child: Consumer<VeloModel>(
                  builder: (context, model, child) {
                    Item currentItem = model.getCurrentItem();
                    return Column(
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
                          model.getCurrentItem().name,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          currentItem.getMoneySavedInEuros().toString() + "€",
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .apply(color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 23, vertical: 8),
                          child: LinearPercentIndicator(
                            lineHeight: 9.0,
                            percent:
                                currentItem.priceReimbursed / currentItem.price,
                            backgroundColor: Colors.white,
                            progressColor: Theme.of(context).accentColor,
                            animation: true,
                            animationDuration: 500,
                            animateFromLastPercent: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            border: Border.all(
                              width: 0,
                              color: Theme.of(context).canvasColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              FloatingActionButton(
                onPressed: () => Provider.of<VeloModel>(context, listen: false)
                    .addMoneyToCurrentItem(190),
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
          Expanded(
            child: Consumer<VeloModel>(builder: (context, model, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GlobalStats("Total économisé",
                      model.getTotalMoneySavedInEuros() + "€"),
                  GlobalStats("Trajets effectués",
                      model.getTotalNumberOfTrips().toString()),
                ],
              );
            }),
          ),
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
