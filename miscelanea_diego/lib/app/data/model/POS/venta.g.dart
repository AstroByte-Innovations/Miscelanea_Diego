// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venta.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VentaAdapter extends TypeAdapter<Venta> {
  @override
  final int typeId = 7;

  @override
  Venta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Venta(
      producto: fields[0] as Producto,
      cantidad: fields[1] as double,
      precio: fields[2] as double,
      subtotal: fields[3] as double,
      total: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Venta obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.producto)
      ..writeByte(1)
      ..write(obj.cantidad)
      ..writeByte(2)
      ..write(obj.precio)
      ..writeByte(3)
      ..write(obj.subtotal)
      ..writeByte(4)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VentaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
