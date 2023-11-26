import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';

class UsuarioModel {
  Future<void> agregarUsuario(Usuario usuario) async {
    final usuariosBox = await Hive.openBox<Usuario>('usuarios');
    await usuariosBox.add(usuario);
  }

  Future<Usuario?> obtenerUsuario(int key) async {
    final usuariosBox = await Hive.openBox<Usuario>('usuarios');
    return usuariosBox.get(key);
  }

  Future<List<Usuario>> obtenerTodosUsuarios() async {
    final usuariosBox = await Hive.openBox<Usuario>('usuarios');
    return usuariosBox.values.toList();
  }

  Future<void> eliminarUsuario(int key) async {
    final usuariosBox = await Hive.openBox<Usuario>('usuarios');
    await usuariosBox.delete(key);
  }

  Future<void> actualizarUsuario(int key, Usuario usuario) async {
    final usuariosBox = await Hive.openBox<Usuario>('usuarios');
    await usuariosBox.put(key, usuario);
  }

  Future<void> reiniciarUsuarios() async {
    final usuariosBox = await Hive.openBox<Usuario>('usuarios');
    await usuariosBox.clear();
    usuariosBox.close();
  }
}
