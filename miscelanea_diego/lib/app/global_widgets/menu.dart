import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/screens/auditoria_screen/auditoria_screen.dart';
import 'package:miscelanea_diego/app/screens/inventario_screen/inventario_screen.dart';
import 'package:miscelanea_diego/app/screens/login/login.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/pos_screen.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/categoria_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/productos_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/productos_screen.dart';
import 'package:miscelanea_diego/app/screens/usuarios_screen/usuarios_screen.dart';

class Menu {
  static Widget buildMenu(BuildContext context, Usuario usuario) {
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
                SizedBox(
                  width: 150,
                  child: Text(
                    "Hola, ${usuario.nombre}\n${usuario.apellidoPaterno}",
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          (usuario.role.puntoVenta)
              ? ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (c) {
                      return POSScreen(
                        usuario: usuario,
                      );
                    }));
                  },
                  leading: const Icon(Icons.shopping_cart,
                      size: 25.0, color: Colors.white),
                  title: const Text("Punto de venta"),
                  textColor: Colors.white,
                  dense: true,
                )
              : Container(),
          (usuario.role.productos)
              ? ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (c) {
                      return ProductosScreen(
                        usuario: usuario,
                        controller: ProductoController(usuario: usuario),
                        controllerCategoria:
                            CategoriaController(usuario: usuario),
                      );
                    }));
                  },
                  leading: const Icon(Icons.shopping_bag,
                      size: 25.0, color: Colors.white),
                  title: const Text("Productos"),
                  textColor: Colors.white,
                  dense: true,
                )
              : Container(),
          (usuario.role.inventario)
              ? ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (c) {
                      return InventarioScreen(
                        usuario: usuario,
                        controller: ProductoController(usuario: usuario),
                        controllerCategoria:
                            CategoriaController(usuario: usuario),
                      );
                    }));
                  },
                  leading: const Icon(Icons.inventory,
                      size: 25.0, color: Colors.white),
                  title: const Text("Inventario"),
                  textColor: Colors.white,
                  dense: true,
                )
              : Container(),
          (usuario.role.reportes)
              ? ListTile(
                  onTap: () {},
                  leading:
                      const Icon(Icons.edit, size: 25.0, color: Colors.white),
                  title: const Text("Reportes"),
                  textColor: Colors.white,
                  dense: true,

                  // padding: EdgeInsets.zero,
                )
              : Container(),
          (usuario.role.ventas)
              ? ListTile(
                  onTap: () {},
                  leading:
                      const Icon(Icons.sell, size: 25.0, color: Colors.white),
                  title: const Text("Ventas"),
                  textColor: Colors.white,
                  dense: true,

                  // padding: EdgeInsets.zero,
                )
              : Container(),
          (usuario.role.usuarios)
              ? ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (c) {
                      return UsuariosScreen(
                        usuario: usuario,
                      );
                    }));
                  },
                  leading:
                      const Icon(Icons.person, size: 25.0, color: Colors.white),
                  title: const Text("Usuarios"),
                  textColor: Colors.white,
                  dense: true,
                  // padding: EdgeInsets.zero,
                )
              : Container(),
          (usuario.role.auditoria)
              ? ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (c) {
                      return AuditoriaScreen(
                        usuarioGlobal: usuario,
                      );
                    }));
                  },
                  leading: const Icon(Icons.verified,
                      size: 25.0, color: Colors.white),
                  title: const Text("Auditoria"),
                  textColor: Colors.white,
                  dense: true,
                  // padding: EdgeInsets.zero,
                )
              : Container(),
          (usuario.role.configuracion)
              ? ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.settings,
                      size: 25.0, color: Colors.white),
                  title: const Text("Configuracion"),
                  textColor: Colors.white,
                  dense: true,
                  // padding: EdgeInsets.zero,
                )
              : Container(),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (c) {
                return const Login();
              }));
            },
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
