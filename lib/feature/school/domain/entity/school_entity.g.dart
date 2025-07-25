// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SchoolEntityAdapter extends TypeAdapter<SchoolEntity> {
  @override
  final int typeId = 0;

  @override
  SchoolEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SchoolEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      address: fields[2] as String,
      notes: fields[3] as String?,
      created: fields[4] as DateTime,
      updated: fields[5] as DateTime,
      createdBy: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SchoolEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.notes)
      ..writeByte(4)
      ..write(obj.created)
      ..writeByte(5)
      ..write(obj.updated)
      ..writeByte(6)
      ..write(obj.createdBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchoolEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
