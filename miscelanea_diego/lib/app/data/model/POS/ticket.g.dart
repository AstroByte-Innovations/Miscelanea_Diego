// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketAdapter extends TypeAdapter<Ticket> {
  @override
  final int typeId = 6;

  @override
  Ticket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ticket(
      fecha: fields[0] as DateTime,
      cantidadProductos: fields[1] as double,
      subtotal: fields[2] as double,
      total: fields[3] as double,
      efectivo: fields[4] as double,
      cambio: fields[5] as double,
      ventas: (fields[6] as List).cast<Venta>(),
    );
  }

  @override
  void write(BinaryWriter writer, Ticket obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.fecha)
      ..writeByte(1)
      ..write(obj.cantidadProductos)
      ..writeByte(2)
      ..write(obj.subtotal)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.efectivo)
      ..writeByte(5)
      ..write(obj.cambio)
      ..writeByte(6)
      ..write(obj.ventas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
