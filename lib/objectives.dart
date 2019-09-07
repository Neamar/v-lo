import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class ObjectivePage extends StatelessWidget {
  static const double ICON_SIZE = 80;
  static const radius = Radius.circular(ICON_SIZE);
  final String title;

  ObjectivePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VeloModel>(builder: (context, model, child) {
      return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: model.items.length * 3,
          itemBuilder: (BuildContext context, int index) {
            Item item = model.items[0];
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  item.getIcon(),
                  size: 40,
                  color: Colors.red,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      item.name,
                    ),
                    LinearPercentIndicator(
                      width: 250,
                      lineHeight: 9.0,
                      percent: item.priceReimbursed / item.price,
                      backgroundColor: Colors.white,
                      progressColor: Theme.of(context).accentColor,
                    ),
                    Text(
                      item.priceReimbursed.toString() +
                          "€ remboursés sur " +
                          item.price.toString(),
                    ),
                  ],
                )
              ],
            );
          });
    });
  }
}
