import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario_model.dart';

class UsuariosController {
  final UsuarioModel modelo = UsuarioModel();
  UsuariosController();

  Future<List<Usuario>> cargarUsuarios() {
    return modelo.obtenerTodosUsuarios();
  }

  void agregarUsuario(Usuario usuario) {
    modelo.agregarUsuario(usuario);
  }

  void editarUsuario(Usuario usuario, int key) {
    modelo.actualizarUsuario(key, usuario);
  }

  void eliminarUsuario(int key) {
    modelo.eliminarUsuario(key);
  }
}
