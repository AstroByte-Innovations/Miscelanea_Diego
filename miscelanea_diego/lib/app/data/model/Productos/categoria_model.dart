import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/data/model/Productos/categoria.dart';

class CategoriaModel {
  Future<void> agregarCategoria(Categoria categoria) async {
    final categoriaBox = await Hive.openBox<Categoria>('categorias');
    categoriaBox.add(categoria);
  }

  Future<List<Categoria>> obtenerTodasCategorias() async {
    final categoriaBox = await Hive.openBox<Categoria>('categorias');
    return categoriaBox.values.toList();
  }

  Future<Categoria?> obtenerCategoria(int key) async {
    final categoriaBox = await Hive.openBox<Categoria>('categorias');
    return categoriaBox.get(key);
  }

  Future<void> actualizarCategoria(Categoria categoria, int key) async {
    final categoriaBox = await Hive.openBox<Categoria>('categorias');
    categoriaBox.put(key, categoria);
  }

  Future<void> eliminarCategoria(int key) async {
    final categoriaBox = await Hive.openBox<Categoria>('categorias');
    categoriaBox.delete(key);
  }

  Future<void> reiniciarCategorias() async {
    final categoriaBox = await Hive.openBox<Categoria>('categorias');
    categoriaBox.clear();
    categoriaBox.close();
  }
}
