import 'dart:collection';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Item {
  int price;
  int priceReimbursed;
  int numberOfTrips;
  String name;

  Item(String fromString) {
    List<String> values = fromString.split("|");
    price = int.parse(values[0]);
    priceReimbursed = int.parse(values[1]);
    numberOfTrips = int.parse(values[2]);
    name = values[3];
  }

  String getMoneySavedInEuros() {
    return (priceReimbursed / 100).toStringAsFixed(2);
  }

  String toString() {
    return this.price.toString() + "|" + this.priceReimbursed.toString() + "|" +
        this.numberOfTrips.toString() + "|" + this.name.replaceAll("|", "");
  }

}

class VeloModel extends ChangeNotifier {
  static final SP_KEY = "items";

  SharedPreferences _prefs;

  List<Item> _items = [];
  bool isLoading = true;

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  Future<List<Item>> readStateFromDisk() async {

    _prefs = await SharedPreferences.getInstance();
    if (!_prefs.containsKey(SP_KEY)) {
      _prefs.setStringList(SP_KEY, ["2000|0|0|Casque de vélo"]);
    }

    List<String> itemsAsStrings = _prefs.getStringList(SP_KEY);
    List<Item> items = [];

    for (int i = 0; i < itemsAsStrings.length; i++) {
      Item item = Item(itemsAsStrings[i]);
      items.add(item);
    }

    return items;
  }

  void writeStateToDisk() async {
    List<String> serialized = _items.map((item) {
      return item.toString();
    }).toList();

    await _prefs.setStringList(SP_KEY, serialized);
  }

  VeloModel() {
    log("Loading model");
    readStateFromDisk().then((items) {
      this.isLoading = false;
      this._items = items;
      log("Model loaded");

      this.notifyListeners();
    }).catchError((error) {
      log(error.toString());
    });
  }

  Item getCurrentItem() {
    return this._items[0];
  }

  void addMoneyToCurrentItem(int value) {
    Item item = getCurrentItem();
    item.priceReimbursed += value;
    item.numberOfTrips += 1;
    notifyListeners();
  }

  String getTotalMoneySavedInEuros() {
    String r = ((getCurrentItem().priceReimbursed + 550) / 100)
        .round()
        .toString();
    return r;
  }

  int getTotalNumberOfTrips() {
    return this._items[0].numberOfTrips;
  }

  @override
  void notifyListeners() {
    writeStateToDisk();
    super.notifyListeners();
  }

}