// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_school_param.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreateSchoolParamAdapter extends TypeAdapter<CreateSchoolParam> {
  @override
  final int typeId = 6;

  @override
  CreateSchoolParam read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreateSchoolParam(
      name: fields[0] as String,
      address: fields[1] as String,
      notes: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CreateSchoolParam obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateSchoolParamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
