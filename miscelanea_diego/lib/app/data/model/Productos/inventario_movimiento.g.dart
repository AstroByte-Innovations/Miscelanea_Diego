// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventario_movimiento.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovimientoAlmacenAdapter extends TypeAdapter<MovimientoAlmacen> {
  @override
  final int typeId = 5;

  @override
  MovimientoAlmacen read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovimientoAlmacen(
      sku: fields[0] as String,
      nombre: fields[1] as String,
      fecha: fields[2] as DateTime,
      tipo: fields[3] as int,
      cantidadA: fields[4] as double,
      cantidad: fields[5] as double,
      cantidadF: fields[6] as double,
      usuario: fields[7] as Usuario,
    );
  }

  @override
  void write(BinaryWriter writer, MovimientoAlmacen obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.sku)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.fecha)
      ..writeByte(3)
      ..write(obj.tipo)
      ..writeByte(4)
      ..write(obj.cantidadA)
      ..writeByte(5)
      ..write(obj.cantidad)
      ..writeByte(6)
      ..write(obj.cantidadF)
      ..writeByte(7)
      ..write(obj.usuario);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovimientoAlmacenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
