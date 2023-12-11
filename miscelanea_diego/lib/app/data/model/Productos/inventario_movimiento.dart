import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';

part 'inventario_movimiento.g.dart';

@HiveType(typeId: 5)
class MovimientoAlmacen extends HiveObject {
  MovimientoAlmacen(
      {required this.sku,
      required this.nombre,
      required this.fecha,
      required this.tipo,
      required this.cantidadA,
      required this.cantidad,
      required this.cantidadF,
      required this.usuario});
  @HiveField(0)
  String sku;
  @HiveField(1)
  String nombre;
  @HiveField(2)
  DateTime fecha;
  @HiveField(3)
  int tipo;
  @HiveField(4)
  double cantidadA;
  @HiveField(5)
  double cantidad;
  @HiveField(6)
  double cantidadF;
  @HiveField(7)
  Usuario usuario;

  @override
  String toString() {
    return 'Movimiento almacen{sku: $sku, nombre: $nombre, fecha: $fecha, tipo: $tipo, cantidad anterior $cantidadA, cantidad: $cantidad, cantidad final: $cantidadF}';
  }
}
