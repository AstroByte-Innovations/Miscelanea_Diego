import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria_model.dart';

class AuditoriasController {
  AuditoriaModel modelo = AuditoriaModel();

  Future<List<Auditoria>> cargarAuditorias() async {
    return await modelo.obtenerTodasAuditorias();
  }
}
