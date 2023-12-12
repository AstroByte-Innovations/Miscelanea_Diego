import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/data/model/POS/venta.dart';

class VentaModelo {
  Future<void> agregarVenta(Venta ticket) async {
    final ticketsBox = await Hive.openBox<Venta>('ventas');
    ticketsBox.add(ticket);
  }

  Future<List<Venta>> obtenerTodosTickets() async {
    final ticketsBox = await Hive.openBox<Venta>('ventas');
    return ticketsBox.values.toList();
  }
}
