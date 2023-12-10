import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto_model.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria_model.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';

class ProductoController {
  ProductoModel modelo = ProductoModel();
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
