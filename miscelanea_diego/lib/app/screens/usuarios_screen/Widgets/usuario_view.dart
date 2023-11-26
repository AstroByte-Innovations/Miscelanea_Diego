import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';

class UsuarioView extends StatelessWidget {
  const UsuarioView({super.key, required this.usuario, required this.onPress});
  final Usuario usuario;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPress,
        icon: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.background),
          child: const Icon(
            Icons.person,
            size: 25,
          ),
        ),
        label: Column(
          children: [Text(usuario.nombre)],
        ));
  }
}
