import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/role.dart';

part 'usuario.g.dart';

@HiveType(typeId: 0)
class Usuario extends HiveObject {
  //Login
  @HiveField(0)
  String nombreUsuario;
  @HiveField(1)
  String pin;
  // Datos generales
  @HiveField(2)
  String nombre;
  @HiveField(3)
  String apellidoPaterno;
  @HiveField(4)
  String? apellidoMaterno;
  // Backend
  @HiveField(5)
  DateTime? fechaCreacion;
  @HiveField(6)
  DateTime? fechaActualizacion;
  // permisos
  @HiveField(7)
  Role role;

  Usuario(
      {required this.nombreUsuario,
      required this.pin,
      required this.nombre,
      required this.apellidoPaterno,
      required this.apellidoMaterno,
      required this.role,
      this.fechaCreacion,
      this.fechaActualizacion});

  // Map<String, dynamic> toJson() {
  //   return {
  //     'nombre': nombre,
  //     'pin': pin,
  //   };
  // }

  // static Usuario fromJson(Map<String, dynamic> json) {
  //   return Usuario(
  //     nombre: json['nombre'],
  //     pin: json['pin'],
  //   );
  // }

  @override
  String toString() {
    return 'Usuario: {nombreUsuario: $nombreUsuario,nombre: $nombre,apellidoPaterno: $apellidoPaterno,apellidoMaterno: $apellidoMaterno,fechaCreacion: $fechaCreacion,fechaActualizacion: $fechaActualizacion,role: $role,}';
  }
}
