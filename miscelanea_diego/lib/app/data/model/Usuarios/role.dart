import 'package:hive/hive.dart';

part 'role.g.dart';

@HiveType(typeId: 1)
class Role extends HiveObject {
  @HiveField(0)
  bool puntoVenta;
  @HiveField(1)
  bool productos;
  @HiveField(2)
  bool inventario;
  @HiveField(3)
  bool reportes;
  @HiveField(4)
  bool ventas;
  @HiveField(5)
  bool usuarios;
  @HiveField(6)
  bool auditoria;
  @HiveField(7)
  bool configuracion;

  Role(
      {required this.puntoVenta,
      required this.productos,
      required this.inventario,
      required this.reportes,
      required this.ventas,
      required this.usuarios,
      required this.auditoria,
      required this.configuracion});

  @override
  String toString() {
    return 'Role: {puntoVenta: $puntoVenta, productos: $productos, inventario: $inventario, reportes: $reportes, ventas: $ventas,usuarios: $usuarios,auditoria: $auditoria,configuracion: $configuracion,}';
  }
}
