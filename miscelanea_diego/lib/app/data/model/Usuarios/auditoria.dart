import 'package:hive/hive.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';

part 'auditoria.g.dart';

@HiveType(typeId: 1)
class Auditoria extends HiveObject {
  @HiveField(0)
  Usuario usuario;
  @HiveField(1)
  String tipoRegistro;
  @HiveField(2)
  String accion;
  @HiveField(3)
  DateTime fecha;
  @HiveField(4)
  String registro;
  @HiveField(5)
  String descripcion;
  @HiveField(6)
  Auditoria(
      {required this.usuario,
      required this.tipoRegistro,
      required this.accion,
      required this.fecha,
      required this.registro,
      required this.descripcion});
}
