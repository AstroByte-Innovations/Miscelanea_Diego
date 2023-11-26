// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoleAdapter extends TypeAdapter<Role> {
  @override
  final int typeId = 1;

  @override
  Role read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Role(
      puntoVenta: fields[0] as bool,
      productos: fields[1] as bool,
      inventario: fields[2] as bool,
      reportes: fields[3] as bool,
      ventas: fields[4] as bool,
      usuarios: fields[5] as bool,
      auditoria: fields[6] as bool,
      configuracion: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Role obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.puntoVenta)
      ..writeByte(1)
      ..write(obj.productos)
      ..writeByte(2)
      ..write(obj.inventario)
      ..writeByte(3)
      ..write(obj.reportes)
      ..writeByte(4)
      ..write(obj.ventas)
      ..writeByte(5)
      ..write(obj.usuarios)
      ..writeByte(6)
      ..write(obj.auditoria)
      ..writeByte(7)
      ..write(obj.configuracion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
