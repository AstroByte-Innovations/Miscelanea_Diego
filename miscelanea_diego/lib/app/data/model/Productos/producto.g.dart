// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductoAdapter extends TypeAdapter<Producto> {
  @override
  final int typeId = 4;

  @override
  Producto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Producto(
      sku: fields[0] as String,
      nombre: fields[1] as String,
      precio: fields[2] as double,
      estado: fields[3] as int,
      tipo: fields[4] as int,
      categoria: fields[6] as Categoria,
      cantidad: fields[9] as double,
      descrcipcion: fields[5] as String?,
      fechaCreacion: fields[7] as DateTime?,
      fechaActualizacion: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Producto obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.sku)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.precio)
      ..writeByte(3)
      ..write(obj.estado)
      ..writeByte(4)
      ..write(obj.tipo)
      ..writeByte(5)
      ..write(obj.descrcipcion)
      ..writeByte(6)
      ..write(obj.categoria)
      ..writeByte(7)
      ..write(obj.fechaCreacion)
      ..writeByte(8)
      ..write(obj.fechaActualizacion)
      ..writeByte(9)
      ..write(obj.cantidad);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
