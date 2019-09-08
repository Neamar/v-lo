import 'package:flutter/material.dart';

abstract class AppTab extends StatelessWidget {

  FloatingActionButton getFloatingActionButton(BuildContext context) {
    return null;
  }

  AppTab({Key key});
}