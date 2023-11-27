import 'package:hive/hive.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';

part 'auditoria.g.dart';

@HiveType(typeId: 2)
class Auditoria extends HiveObject {
  //Empleado que realizo
  @HiveField(0)
  Usuario usuario;
  @HiveField(1)
  //Categoria que realizo
  String tipoRegistro;
  @HiveField(2)
  // Creo, edito, elimino
  String accion;
  @HiveField(3)
  //Fecha
  DateTime fecha;
  @HiveField(4)
  //a quien le hizo el cambio
  String registro;
  //Cambios
  @HiveField(5)
  String descripcion;
  Auditoria(
      {required this.usuario,
      required this.tipoRegistro,
      required this.accion,
      required this.fecha,
      required this.registro,
      required this.descripcion});
  @override
  String toString() {
    return 'Auditoria(usuario: $usuario, tipoRegistro: $tipoRegistro, accion: $accion, fecha: $fecha, registro: $registro, descripcion: $descripcion)';
  }
}
