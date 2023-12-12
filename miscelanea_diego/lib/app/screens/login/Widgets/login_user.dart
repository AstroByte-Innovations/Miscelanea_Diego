import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/pos_controller.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/pos_screen.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/productos_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key, required this.usuario});
  final Usuario usuario;

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.regresarAppBar(context, "Ingresar"),
      body: PopScope(
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Nombre de Usuario:',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        widget.usuario.nombreUsuario,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(height: 0),
                  const Text(
                    'Ingrese el pin',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  PinCodeTextField(
                    autoFocus: true,
                    controller: controller,
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '*',
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 40,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Por favor ingresa un pin de 6 digitos';
                      } else if (value.isEmpty) {
                        return 'Por favor ingresa un pin valido';
                      }
                      return null;
                    },
                  ),
                  const Divider(height: 0),
                  const SizedBox(height: 20),
                  FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String value = controller.text;
                          if (value.compareTo(widget.usuario.pin) == 0) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (c) {
                              return POSScreen(
                                controllerProducto:
                                    ProductoController(usuario: widget.usuario),
                                controller:
                                    PosController(usuario: widget.usuario),
                                usuario: widget.usuario,
                              );
                            }));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return GlobalWidgets.mensajeError(
                                      'El pin ingresado es incorrecto',
                                      'Advertencia',
                                      context);
                                });
                          }
                        }
                      },
                      child: const Text('Ingresar'))
                ],
              )),
        )),
      ),
    );
  }
}
