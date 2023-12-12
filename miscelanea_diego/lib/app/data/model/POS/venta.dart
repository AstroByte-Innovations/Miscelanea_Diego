import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';

part 'venta.g.dart';

@HiveType(typeId: 7)
class Venta extends HiveObject {
  Venta(
      {required this.producto,
      required this.cantidad,
      required this.precio,
      required this.subtotal,
      required this.total});
  @HiveField(0)
  Producto producto;
  @HiveField(1)
  double cantidad;
  @HiveField(2)
  double precio;
  @HiveField(3)
  double subtotal;
  @HiveField(4)
  double total;

  @override
  String toString() {
    return 'Venta { '
        'producto: $producto, '
        'cantidad: $cantidad, '
        'precio: $precio, '
        'subtotal: $subtotal, '
        'total: $total '
        '}';
  }
}
