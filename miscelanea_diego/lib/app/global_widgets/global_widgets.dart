import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/global_widgets/colorfondo.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class GlobalWidgets {
  static final List<ColorFondo> colores = [
    const ColorFondo(key: 0, color: Colors.green, nombre: 'Verde'),
    const ColorFondo(key: 1, color: Colors.blue, nombre: 'Azul'),
    const ColorFondo(key: 2, color: Colors.yellow, nombre: 'Amarrillo'),
    const ColorFondo(key: 3, color: Colors.orange, nombre: 'Naranja'),
    const ColorFondo(key: 4, color: Colors.pink, nombre: 'Rosa'),
    const ColorFondo(key: 5, color: Colors.purple, nombre: 'Morado'),
    const ColorFondo(key: 6, color: Colors.indigo, nombre: 'Indigo'),
    const ColorFondo(key: 7, color: Colors.teal, nombre: 'Teal'),
    const ColorFondo(key: 8, color: Colors.cyan, nombre: 'Cyan'),
    const ColorFondo(key: 9, color: Colors.lime, nombre: 'Lima'),
    const ColorFondo(key: 10, color: Colors.brown, nombre: 'Cafe'),
    const ColorFondo(key: 11, color: Colors.red, nombre: 'Rojo'),
  ];

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

  static AppBar regresarEditarAppBar(
      BuildContext context, String title, VoidCallback onPress) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(title),
      actions: [IconButton(onPressed: onPress, icon: const Icon(Icons.delete))],
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

  static Future<bool> mesajeConfirmar(
      String title, String text, BuildContext context) async {
    bool opcion = false;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              const Icon(Icons.warning),
              const SizedBox(width: 10),
              Text(title)
            ]),
            content: Text(text),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    opcion = false;
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar')),
              FilledButton(
                  onPressed: () {
                    opcion = true;
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Aceptar'))
            ],
          );
        });
    return opcion;
  }

  static ColorFondo getColorFondo(int color) {
    return colores[color];
  }

  static void showBackDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Desea salir?'),
          content: const Text(
            'Los cambios que no haya guardado se perderán.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Salir'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static Card coloresFondo(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Text('Selecciona un color'),
          Expanded(
              child: ListView.builder(
                  itemCount: colores.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        Icons.circle,
                        color: colores[index].color,
                      ),
                      title: Text(colores[index].nombre),
                      onTap: () => Navigator.of(context).pop(colores[index]),
                    );
                  }))
        ],
      ),
    );
  }
}
