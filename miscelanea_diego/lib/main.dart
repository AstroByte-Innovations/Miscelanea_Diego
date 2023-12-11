import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/core/theme/app_theme.dart';
import 'package:miscelanea_diego/app/data/model/Productos/categoria.dart';
import 'package:miscelanea_diego/app/data/model/Productos/inventario_movimiento.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/role.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/screens/login/login.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UsuarioAdapter());
  Hive.registerAdapter(RoleAdapter());
  Hive.registerAdapter(AuditoriaAdapter());
  Hive.registerAdapter(CategoriaAdapter());
  Hive.registerAdapter(ProductoAdapter());
  Hive.registerAdapter(MovimientoAlmacenAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miscelanea Diego',
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
