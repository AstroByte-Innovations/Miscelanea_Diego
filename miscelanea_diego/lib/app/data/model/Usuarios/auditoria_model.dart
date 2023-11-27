import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria.dart';

class AuditoriaModel {
  Future<void> agregarAuditoria(Auditoria auditoria) async {
    final auditoriaBox = await Hive.openBox<Auditoria>('auditorias');
    await auditoriaBox.add(auditoria);
  }

  Future<List<Auditoria>> obtenerTodasAuditorias() async {
    final auditoriaBox = await Hive.openBox<Auditoria>('auditorias');
    return auditoriaBox.values.toList();
  }
}
