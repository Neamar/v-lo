import 'dart:collection';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class Item {
  int price;
  int priceReimbursed;
  String name;

  Item(this.price, this.priceReimbursed, this.name);

  String getMoneySavedInEuros() {
    return (priceReimbursed / 100).toStringAsFixed(2);
  }

}

class VeloModel extends ChangeNotifier {
  int _numberOfTrips = 5;

  List<Item> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  VeloModel() {
    this._items = [Item(2000, 500, "Casque de vélo")];
  }

  Item getCurrentItem() {
    return this._items[0];
  }

  void addMoneyToCurrentItem(int value) {
    getCurrentItem().priceReimbursed += value;
    _numberOfTrips++;
    notifyListeners();
  }

  String getTotalMoneySavedInEuros() {
    String r = ((getCurrentItem().priceReimbursed + 550) / 100).round().toString();
    return r;
  }

  int getTotalNumberOfTrips() {
    return _numberOfTrips;
  }

}