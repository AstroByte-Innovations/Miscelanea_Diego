import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/data/model/POS/venta.dart';

part 'ticket.g.dart';

@HiveType(typeId: 6)
class Ticket extends HiveObject {
  Ticket(
      {required this.fecha,
      required this.cantidadProductos,
      required this.subtotal,
      required this.total,
      required this.efectivo,
      required this.cambio,
      required this.ventas});
  @HiveField(0)
  DateTime fecha;
  @HiveField(1)
  double cantidadProductos;
  @HiveField(2)
  double subtotal;
  @HiveField(3)
  double total;
  @HiveField(4)
  double efectivo;
  @HiveField(5)
  double cambio;
  @HiveField(6)
  List<Venta> ventas;

  @override
  String toString() {
    return 'Ticket { '
        'fecha: $fecha, '
        'cantidadProductos: $cantidadProductos, '
        'subtotal: $subtotal, '
        'total: $total, '
        'efectivo: $efectivo, '
        'cambio: $cambio, '
        'ventas: $ventas '
        '}';
  }
}
