// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auditoria.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuditoriaAdapter extends TypeAdapter<Auditoria> {
  @override
  final int typeId = 1;

  @override
  Auditoria read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Auditoria(
      usuario: fields[0] as Usuario,
      tipoRegistro: fields[1] as String,
      accion: fields[2] as String,
      fecha: fields[3] as DateTime,
      registro: fields[4] as String,
      descripcion: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Auditoria obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.usuario)
      ..writeByte(1)
      ..write(obj.tipoRegistro)
      ..writeByte(2)
      ..write(obj.accion)
      ..writeByte(3)
      ..write(obj.fecha)
      ..writeByte(4)
      ..write(obj.registro)
      ..writeByte(5)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuditoriaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
