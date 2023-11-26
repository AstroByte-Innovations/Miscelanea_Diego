import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/pos_screen.dart';
import 'package:miscelanea_diego/app/screens/usuarios_screen/usuarios_screen.dart';

class Menu {
  static Widget buildMenu(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16.0),
                const Text(
                  "Hola, Marcos Falcon",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (c) {
                return const POSScreen();
              }));
            },
            leading: const Icon(Icons.shopping_cart,
                size: 25.0, color: Colors.white),
            title: const Text("Punto de venta"),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {},
            leading:
                const Icon(Icons.shopping_bag, size: 25.0, color: Colors.white),
            title: const Text("Productos"),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {},
            leading:
                const Icon(Icons.inventory, size: 25.0, color: Colors.white),
            title: const Text("Inventario"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.edit, size: 25.0, color: Colors.white),
            title: const Text("Reportes"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.sell, size: 25.0, color: Colors.white),
            title: const Text("Ventas"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (c) {
                return const UsuariosScreen();
              }));
            },
            leading: const Icon(Icons.person, size: 25.0, color: Colors.white),
            title: const Text("Usuarios"),
            textColor: Colors.white,
            dense: true,
            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading:
                const Icon(Icons.verified, size: 25.0, color: Colors.white),
            title: const Text("Auditoria"),
            textColor: Colors.white,
            dense: true,
            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading:
                const Icon(Icons.settings, size: 25.0, color: Colors.white),
            title: const Text("Configuracion"),
            textColor: Colors.white,
            dense: true,
            // padding: EdgeInsets.zero,
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.logout, size: 30.0, color: Colors.white),
            title: const Text("Cerrar sesion"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
