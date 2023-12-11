import 'package:miscelanea_diego/app/data/model/Productos/inventario_movimiento.dart';
import 'package:miscelanea_diego/app/data/model/Productos/inventario_movimiento_model.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto_model.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria_model.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';

class ProductoController {
  ProductoModel modelo = ProductoModel();
  InventarioMovimientoModel modeloIM = InventarioMovimientoModel();
  final AuditoriaModel modeloAu = AuditoriaModel();
  Usuario usuario;
  ProductoController({required this.usuario});

  void creatProducto(Producto producto) async {
    await modelo.agregarProducto(producto);

    agregarAuditoria(Auditoria(
        usuario: usuario,
        tipoRegistro: 'Producto',
        accion: 'Creacion',
        fecha: DateTime.now(),
        registro: "${producto.sku} ${producto.nombre}",
        descripcion: producto.toString()));

    modeloIM.agregarMovimiento(MovimientoAlmacen(
        sku: producto.sku,
        nombre: producto.nombre,
        fecha: DateTime.now(),
        tipo: 1,
        cantidadA: 0,
        cantidad: producto.cantidad,
        cantidadF: producto.cantidad,
        usuario: usuario));
  }

  Future<List<Producto>> cargarProductos() async {
    return await modelo.obtenerTodosProductos();
  }

  void actualizarProducto(int key, Producto producto) async {
    modelo.actualizarProducto(producto, key);
    agregarAuditoria(Auditoria(
        usuario: usuario,
        tipoRegistro: 'Producto',
        accion: 'Actualizacion',
        fecha: DateTime.now(),
        registro: "${producto.sku} ${producto.nombre}",
        descripcion: producto.toString()));
  }

  void eliminarProducto(int key, Producto producto) async {
    modelo.eliminarProducto(key);
    agregarAuditoria(Auditoria(
        usuario: usuario,
        tipoRegistro: 'Producto',
        accion: 'Eliminacion',
        fecha: DateTime.now(),
        registro: "${producto.sku} ${producto.nombre}",
        descripcion: producto.toString()));
  }

  void agregarAuditoria(Auditoria auditoria) {
    modeloAu.agregarAuditoria(auditoria);
  }
}
