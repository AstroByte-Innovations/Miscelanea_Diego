import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/data/model/Productos/categoria.dart';

part 'producto.g.dart';

@HiveType(typeId: 4)
class Producto extends HiveObject {
  @HiveField(0)
  String sku;
  @HiveField(1)
  String nombre;
  @HiveField(2)
  double precio;
  @HiveField(3)
  // 0 = agotado 1 = warning 2 = disponible
  int estado;
  @HiveField(4)
  // 1 = pieza 2 = granel
  int tipo;
  @HiveField(5)
  String? descrcipcion;
  @HiveField(6)
  Categoria categoria;
  @HiveField(7)
  DateTime? fechaCreacion;
  @HiveField(8)
  DateTime? fechaActualizacion;
  @HiveField(9)
  double cantidad;

  Producto(
      {required this.sku,
      required this.nombre,
      required this.precio,
      required this.estado,
      required this.tipo,
      required this.categoria,
      required this.cantidad,
      this.descrcipcion = "",
      this.fechaCreacion,
      this.fechaActualizacion});

  @override
  String toString() {
    return 'Producto {\n'
        '  SKU: $sku,\n'
        '  Nombre: $nombre,\n'
        '  Precio: $precio,\n'
        '  Estado: $estado (${estado == 0 ? 'Agotado' : (estado == 1 ? 'Warning' : 'Disponible')}),\n'
        '  Tipo: $tipo (${tipo == 1 ? 'Pieza' : 'Granel'}),\n'
        '  Descripción: $descrcipcion,\n'
        '  Categoría: $categoria,\n'
        '  Fecha de Creación: $fechaCreacion,\n'
        '  Fecha de Actualización: $fechaActualizacion,\n'
        '  Cantidad: $cantidad\n'
        '}';
  }
}
