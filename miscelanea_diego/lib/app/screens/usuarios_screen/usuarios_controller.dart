import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria_model.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario_model.dart';

class UsuariosController {
  final UsuarioModel modelo = UsuarioModel();
  final AuditoriaModel modeloAu = AuditoriaModel();
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

  void agregarAuditoria(Auditoria auditoria) {
    modeloAu.agregarAuditoria(auditoria);
  }
}
