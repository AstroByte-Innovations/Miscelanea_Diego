import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/data/model/Productos/inventario_movimiento.dart';

class InventarioMovimientoModel {
  Future<void> agregarMovimiento(MovimientoAlmacen movimiento) async {
    final movimientoBox =
        await Hive.openBox<MovimientoAlmacen>('movimientosAlmacen');
    movimientoBox.add(movimiento);
  }

  Future<List<MovimientoAlmacen>> obtenerTodosMovimientos() async {
    final movimientoBox =
        await Hive.openBox<MovimientoAlmacen>('movimientosAlmacen');
    return movimientoBox.values.toList();
  }

  Future<List<MovimientoAlmacen>> obtenerTodosMovimientosSku(String sku) async {
    final movimientoBox =
        await Hive.openBox<MovimientoAlmacen>('movimientosAlmacen');
    return movimientoBox.values
        .toList()
        .where((m) => m.sku == sku)
        .toList()
        .reversed
        .toList();
  }
}
