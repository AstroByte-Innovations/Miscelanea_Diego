import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario_model.dart';

class LoginController {
  UsuarioModel modelo = UsuarioModel();

  Future<List<Usuario>> obtenerUsuarios() {
    return modelo.obtenerTodosUsuarios();
  }
}
