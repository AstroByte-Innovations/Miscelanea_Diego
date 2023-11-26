import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/global_widgets/pin_screen.dart';

class UsuarioForm extends StatefulWidget {
  const UsuarioForm({super.key});

  @override
  State<UsuarioForm> createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombres = TextEditingController();
  TextEditingController apellidoPaterno = TextEditingController();
  TextEditingController apellidoMaterno = TextEditingController();
  TextEditingController nombreUsuario = TextEditingController();
  String? pin;

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
          if (_formKey.currentState!.validate()) {
            Navigator.of(context).pop(true);
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
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10)),
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
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10)),
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
                          print(value);
                        });
                      },
                      icon: const Icon(Icons.password),
                      label: const Text('Restablecer PIN'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _permisosUsuario() {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
