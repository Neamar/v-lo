import 'dart:collection';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class Item {
  int price;
  int priceReimbursed;
  String name;

  Item(this.price, this.priceReimbursed, this.name);
}

class VeloModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<Item> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  VeloModel() {
    this._items = [Item(2000, 500, "Casque de vélo")];
  }

  Item getCurrentItem() {
    return this._items[0];
  }

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => _items.length * 42;

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

}