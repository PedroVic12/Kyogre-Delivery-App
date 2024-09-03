import 'package:flutter/material.dart';

class NavigationManager {
  static void navigateTo(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  static void navigateRoute(BuildContext context, String route) {
    Navigator.of(context).pushReplacementNamed(route);
  }

  static void navigateToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  static void getBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  static textNavigate(BuildContext context, Widget Widget, String text) {
    return TextButton(
        onPressed: () {
          navigateToPage(context, Widget);
        },
        child: Text(text));
  }
}
