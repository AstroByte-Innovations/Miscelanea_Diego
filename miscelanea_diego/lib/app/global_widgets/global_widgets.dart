import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class GlobalWidgets {
  static AppBar appBar(GlobalKey<SideMenuState> key, String title) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          final state = key.currentState;
          if (state!.isOpened) {
            state.closeSideMenu();
          } else {
            state.openSideMenu();
          }
        },
      ),
      title: Text(title),
    );
  }

  static AppBar regresarAppBar(BuildContext context, String title) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(title),
    );
  }

  static AlertDialog mensajeError(
      String text, String title, BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.warning),
          const SizedBox(
            width: 10,
          ),
          Text(title)
        ],
      ),
      content: Text(text),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
