import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/core/theme/app_theme.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/role.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/pos_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UsuarioAdapter());
  Hive.registerAdapter(RoleAdapter());
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
      home: const POSScreen(),
    );
  }
}
