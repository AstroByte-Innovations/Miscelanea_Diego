import 'package:miscelanea_diego/app/data/model/Productos/categoria.dart';
import 'package:miscelanea_diego/app/data/model/Productos/categoria_model.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria_model.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';

class CategoriaController {
  CategoriaModel modelo = CategoriaModel();
  final AuditoriaModel modeloAu = AuditoriaModel();
  Usuario usuario;
  CategoriaController({required this.usuario});

  void crearCategoria(Categoria categoria) {
    modelo.agregarCategoria(categoria);
    agregarAuditoria(Auditoria(
        usuario: usuario,
        tipoRegistro: 'Categoria',
        accion: 'Creacion',
        fecha: DateTime.now(),
        registro: categoria.nombre,
        descripcion: categoria.toString()));
  }

  Future<List<Categoria>> cargarCategorias() async {
    return modelo.obtenerTodasCategorias();
  }

  void actualizarCategoria(Categoria categoria, int key) {
    modelo.actualizarCategoria(categoria, key);
    agregarAuditoria(Auditoria(
        usuario: usuario,
        tipoRegistro: 'Categoria',
        accion: 'Actualizacion',
        fecha: DateTime.now(),
        registro: categoria.nombre,
        descripcion: categoria.toString()));
  }

  void eliminarCategoria(int key, Categoria categoria) {
    modelo.eliminarCategoria(key);
    agregarAuditoria(Auditoria(
        usuario: usuario,
        tipoRegistro: 'Categoria',
        accion: 'Eliminacion',
        fecha: DateTime.now(),
        registro: categoria.nombre,
        descripcion: categoria.toString()));
  }

  void agregarAuditoria(Auditoria auditoria) {
    modeloAu.agregarAuditoria(auditoria);
  }
}
