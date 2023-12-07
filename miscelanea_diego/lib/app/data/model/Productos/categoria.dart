import 'package:hive_flutter/hive_flutter.dart';

part 'categoria.g.dart';

@HiveType(typeId: 3)
class Categoria extends HiveObject {
  @HiveField(0)
  String nombre;
  @HiveField(1)
  int color;
  @HiveField(2)
  DateTime? fechaCreacion;
  @HiveField(3)
  DateTime? fechaActualizacion;

  Categoria(
      {required this.nombre,
      required this.color,
      this.fechaCreacion,
      this.fechaActualizacion});

  @override
  String toString() {
    return 'Categoria{Nombre: $nombre, Color: $color Fecha de creacion: $fechaCreacion, Fecha de actualizacion: $fechaActualizacion}';
  }
}
