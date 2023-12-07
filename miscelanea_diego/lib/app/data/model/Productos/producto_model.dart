import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';

class CategoriaModel {
  Future<void> agregarProducto(Producto producto) async {
    final productosBox = await Hive.openBox<Producto>('productos');
    productosBox.add(producto);
  }

  Future<List<Producto>> obtenerTodosProductos() async {
    final productosBox = await Hive.openBox<Producto>('productos');
    return productosBox.values.toList();
  }

  Future<Producto?> obtenerProducto(int key) async {
    final productosBox = await Hive.openBox<Producto>('productos');
    return productosBox.get(key);
  }

  Future<void> actualizarProducto(Producto categoria, int key) async {
    final productosBox = await Hive.openBox<Producto>('productos');
    productosBox.put(key, categoria);
  }

  Future<void> eliminarProducto(int key) async {
    final productosBox = await Hive.openBox<Producto>('productos');
    productosBox.delete(key);
  }

  Future<void> reiniciarProductos() async {
    final productosBox = await Hive.openBox<Producto>('productos');
    productosBox.clear();
    productosBox.close();
  }
}
