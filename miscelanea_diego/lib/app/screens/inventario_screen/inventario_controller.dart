import 'package:miscelanea_diego/app/data/model/Productos/inventario_movimiento.dart';
import 'package:miscelanea_diego/app/data/model/Productos/inventario_movimiento_model.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';

class InventarioController {
  InventarioController({required this.usuario});
  InventarioMovimientoModel modelo = InventarioMovimientoModel();
  Usuario usuario;

  Future<List<MovimientoAlmacen>> cargarMovimientosSku(String sku) async {
    return await modelo.obtenerTodosMovimientosSku(sku);
  }

  void agregarMovimiento(MovimientoAlmacen movimiento) {
    modelo.agregarMovimiento(movimiento);
  }
}
