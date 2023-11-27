import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/role.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/pos_screen.dart';

class LoginGlobal extends StatefulWidget {
  const LoginGlobal({super.key});

  @override
  State<LoginGlobal> createState() => _LoginGlobalState();
}

class _LoginGlobalState extends State<LoginGlobal> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.regresarAppBar(context, "Ingresar"),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Clave de Administrador',
                ),
                controller: _passwordController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (verifyAdminPassword(_passwordController.text)) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (c) {
                      return POSScreen(
                        usuario: Usuario(
                            nombreUsuario: 'Adminstrador',
                            pin: '000000',
                            nombre: 'Administrador',
                            apellidoPaterno: 'Administrador',
                            apellidoMaterno: 'Administrador',
                            role: Role(
                                puntoVenta: true,
                                productos: true,
                                inventario: true,
                                reportes: true,
                                ventas: true,
                                usuarios: true,
                                auditoria: true,
                                configuracion: true)),
                      );
                    }));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Clave de administrador incorrecta'),
                      ),
                    );
                  }
                },
                child: const Text('Ingresar como Admintrador Global'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool verifyAdminPassword(String password) {
    final adminPassword = md5
        .convert(utf8.encode('Marcos'))
        .toString(); // Replace with actual admin password
    final hashedPassword = md5.convert(utf8.encode(password)).toString();
    return hashedPassword == adminPassword;
  }
}
