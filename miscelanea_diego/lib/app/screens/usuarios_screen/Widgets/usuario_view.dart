import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';

class UsuarioView extends StatelessWidget {
  const UsuarioView({super.key, required this.usuario, required this.onPress});
  final Usuario usuario;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: const ButtonStyle(alignment: Alignment.bottomLeft),
      onPressed: onPress,
      icon: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.background,
        ),
        child: const Icon(
          Icons.person,
          size: 35,
        ),
      ),
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${usuario.nombre} ${usuario.apellidoPaterno} ${usuario.apellidoMaterno}',
          ),
          const SizedBox(width: 10),
          Text(usuario.nombreUsuario),
        ],
      ),
    );
  }
}
