import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/role.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/global_widgets/pin_screen.dart';
import 'package:miscelanea_diego/app/screens/usuarios_screen/usuarios_controller.dart';

class UsuarioForm extends StatefulWidget {
  const UsuarioForm({super.key});

  @override
  State<UsuarioForm> createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  final _formKey = GlobalKey<FormState>();
  UsuariosController controller = UsuariosController();
  TextEditingController nombres = TextEditingController();
  TextEditingController apellidoPaterno = TextEditingController();
  TextEditingController apellidoMaterno = TextEditingController();
  TextEditingController nombreUsuario = TextEditingController();
  String pin = "";
  bool puntoVenta = true;
  bool productos = true;
  bool inventario = true;
  bool reportes = true;
  bool ventas = true;
  bool usuarios = false;
  bool auditoria = false;
  bool config = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.regresarAppBar(context, "Crear usuario"),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.info), text: 'Información'),
                Tab(icon: Icon(Icons.admin_panel_settings), text: 'Permisos'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _informacionUsuario(),
                  _permisosUsuario(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          try {
            if (_formKey.currentState!.validate() && pin.isNotEmpty) {
              Usuario user = Usuario(
                  nombre: nombres.text,
                  apellidoPaterno: apellidoPaterno.text,
                  apellidoMaterno: apellidoMaterno.text,
                  nombreUsuario: nombreUsuario.text,
                  pin: pin,
                  role: Role(
                      puntoVenta: puntoVenta,
                      productos: productos,
                      inventario: inventario,
                      reportes: reportes,
                      ventas: ventas,
                      usuarios: usuarios,
                      auditoria: auditoria,
                      configuracion: config),
                  fechaCreacion: DateTime.now(),
                  fechaActualizacion: DateTime.now());
              controller.agregarUsuario(user);
              Navigator.of(context).pop(1);
            } else if (pin.isEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return GlobalWidgets.mensajeError(
                      "Por favor de ingresar un PIN en el apartado de \"Informacion\".",
                      "Precaucion",
                      context);
                },
              );
            }
          } catch (e) {
            if (nombres.text.isEmpty ||
                apellidoPaterno.text.isEmpty ||
                nombreUsuario.text.isEmpty ||
                pin.isEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return GlobalWidgets.mensajeError(
                      "Por favor de llenar todos los campos en el apartado de \"Informacion\".",
                      "Precaución",
                      context);
                },
              );
            } else {
              Usuario user = Usuario(
                  nombre: nombres.text,
                  apellidoPaterno: apellidoPaterno.text,
                  apellidoMaterno: apellidoMaterno.text,
                  nombreUsuario: nombreUsuario.text,
                  pin: pin,
                  role: Role(
                      puntoVenta: puntoVenta,
                      productos: productos,
                      inventario: inventario,
                      reportes: reportes,
                      ventas: ventas,
                      usuarios: usuarios,
                      auditoria: auditoria,
                      configuracion: config),
                  fechaCreacion: DateTime.now(),
                  fechaActualizacion: DateTime.now());
              controller.agregarUsuario(user);
              Navigator.of(context).pop(1);
            }
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _informacionUsuario() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Text(
                    'Datos generales',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: nombres,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Nombre(s) *')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa un nombre válido.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: apellidoPaterno,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Apellido paterno *')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa un nombre válido.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: apellidoMaterno,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Apellido materno')),
                  ),
                ],
              ),
            ),
            const Divider(height: 10),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Text(
                    'Acceso',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: nombreUsuario,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Nombre de usuario *')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa un nombre válido.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c) {
                          return const PinScreen();
                        })).then((value) {
                          pin = value;
                        });
                      },
                      icon: const Icon(Icons.password),
                      label: const Text('Ingresar PIN'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _permisosUsuario() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('¿Puede ejecutar la opcion de punto de venta?'),
              value: puntoVenta,
              onChanged: (bool value) {
                puntoVenta = value;
                setState(() {});
              },
            ),
            const Divider(height: 0),
            SwitchListTile(
              title: const Text('¿Puede ejecutar la opcion de productos?'),
              value: productos,
              onChanged: (bool value) {
                productos = value;
                setState(() {});
              },
            ),
            const Divider(height: 0),
            SwitchListTile(
              title: const Text('¿Puede ejecutar la opcion de inventario?'),
              value: inventario,
              onChanged: (bool value) {
                inventario = value;
                setState(() {});
              },
            ),
            const Divider(height: 0),
            SwitchListTile(
              title: const Text('¿Puede ejecutar la opcion de reportes?'),
              value: reportes,
              onChanged: (bool value) {
                reportes = value;
                setState(() {});
              },
            ),
            const Divider(height: 0),
            SwitchListTile(
              title: const Text('¿Puede ejecutar la opcion de ventas?'),
              value: ventas,
              onChanged: (bool value) {
                ventas = value;
                setState(() {});
              },
            ),
            const Divider(height: 0),
            SwitchListTile(
              title: const Text('¿Puede ejecutar la opcion de usuarios?'),
              value: usuarios,
              onChanged: (bool value) {
                usuarios = value;
                setState(() {});
              },
            ),
            const Divider(height: 0),
            SwitchListTile(
              title: const Text('¿Puede ejecutar la opcion de auditoria?'),
              value: auditoria,
              onChanged: (bool value) {
                auditoria = value;
                setState(() {});
              },
            ),
            const Divider(height: 0),
            SwitchListTile(
              title: const Text('¿Puede ejecutar la opcion de configuración?'),
              value: config,
              onChanged: (bool value) {
                config = value;
                setState(() {});
              },
            ),
            const Divider(height: 0),
          ],
        ),
      ),
    );
  }
}
