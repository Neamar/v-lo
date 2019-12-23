import 'package:flutter/material.dart';

abstract class AppTab extends StatelessWidget {

  Widget getFloatingActionButton(BuildContext context) {
    return null;
  }

  AppTab({Key key});
}