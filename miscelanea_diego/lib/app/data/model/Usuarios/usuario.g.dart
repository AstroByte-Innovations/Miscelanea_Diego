// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsuarioAdapter extends TypeAdapter<Usuario> {
  @override
  final int typeId = 0;

  @override
  Usuario read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Usuario(
      nombreUsuario: fields[0] as String,
      pin: fields[1] as String,
      nombre: fields[2] as String,
      apellidoPaterno: fields[3] as String,
      apellidoMaterno: fields[4] as String?,
      fechaCreacion: fields[5] as DateTime?,
      fechaActualizacion: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Usuario obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.nombreUsuario)
      ..writeByte(1)
      ..write(obj.pin)
      ..writeByte(2)
      ..write(obj.nombre)
      ..writeByte(3)
      ..write(obj.apellidoPaterno)
      ..writeByte(4)
      ..write(obj.apellidoMaterno)
      ..writeByte(5)
      ..write(obj.fechaCreacion)
      ..writeByte(6)
      ..write(obj.fechaActualizacion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsuarioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
