import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/global_widgets/pin_screen.dart';
import 'package:miscelanea_diego/app/screens/usuarios_screen/usuarios_controller.dart';

class UsuarioEdit extends StatefulWidget {
  final Usuario user;
  final Usuario usuarioGlobal;
  const UsuarioEdit(
      {super.key, required this.user, required this.usuarioGlobal});

  @override
  State<UsuarioEdit> createState() => _UsuarioEditState();
}

class _UsuarioEditState extends State<UsuarioEdit> {
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
    nombres.text = widget.user.nombre.toString();
    apellidoPaterno.text = widget.user.apellidoPaterno.toString();
    apellidoMaterno.text = widget.user.apellidoMaterno.toString();
    nombreUsuario.text = widget.user.nombreUsuario.toString();
    pin = widget.user.pin.toString();
    puntoVenta = widget.user.role.puntoVenta;
    productos = widget.user.role.productos;
    inventario = widget.user.role.inventario;
    reportes = widget.user.role.reportes;
    ventas = widget.user.role.ventas;
    usuarios = widget.user.role.usuarios;
    auditoria = widget.user.role.auditoria;
    config = widget.user.role.configuracion;
    super.initState();
  }

  void close() {
    Navigator.of(context).pop(1);
  }

  void actualizar() {
    widget.user.nombre = nombres.text;
    widget.user.apellidoPaterno = apellidoPaterno.text;
    widget.user.apellidoMaterno = apellidoMaterno.text;
    widget.user.nombreUsuario = nombreUsuario.text;
    widget.user.pin = pin;
    widget.user.role.puntoVenta = puntoVenta;
    widget.user.role.productos = productos;
    widget.user.role.inventario = inventario;
    widget.user.role.reportes = reportes;
    widget.user.role.ventas = ventas;
    widget.user.role.usuarios = usuarios;
    widget.user.role.auditoria = auditoria;
    widget.user.role.configuracion = config;
    widget.user.fechaActualizacion = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.regresarEditarAppBar(
          context, "Editar ${widget.user.nombreUsuario}", () async {
        bool accion = await GlobalWidgets.mesajeConfirmar('Eliminar Usuario',
            '¿Esta seguro de que desea eliminar este usuario?', context);
        if (accion) {
          controller.agregarAuditoria(Auditoria(
              usuario: widget.usuarioGlobal,
              tipoRegistro: 'Usuario',
              accion: 'Eliminacion',
              fecha: DateTime.now(),
              registro: widget.user.nombreUsuario,
              descripcion: widget.user.toString()));
          controller.eliminarUsuario(widget.user.key);
          close();
        }
      }),
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
              actualizar();
              controller.editarUsuario(widget.user, widget.user.key);
              controller.agregarAuditoria(Auditoria(
                  usuario: widget.usuarioGlobal,
                  tipoRegistro: 'Usuario',
                  accion: 'Actualizacion',
                  fecha: DateTime.now(),
                  registro: widget.user.nombreUsuario,
                  descripcion: widget.user.toString()));
              close();
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
              actualizar();
              controller.editarUsuario(widget.user, widget.user.key);
              controller.agregarAuditoria(Auditoria(
                  usuario: widget.usuarioGlobal,
                  tipoRegistro: 'Usuario',
                  accion: 'Actualizacion',
                  fecha: DateTime.now(),
                  registro: widget.user.nombreUsuario,
                  descripcion: widget.user.toString()));
              close();
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
                      label: const Text('Ingresar PIN')),
                  const Divider(height: 10),
                  const Text(
                    'Informacion adicional',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Fecha de ultima actualizacion: ${widget.user.fechaActualizacion}'),
                      Text('Fecha de creacion: ${widget.user.fechaCreacion}'),
                    ],
                  ),
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
