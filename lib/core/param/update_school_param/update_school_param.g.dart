// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_school_param.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UpdateSchoolParamAdapter extends TypeAdapter<UpdateSchoolParam> {
  @override
  final int typeId = 7;

  @override
  UpdateSchoolParam read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UpdateSchoolParam(
      id: fields[3] as int,
      name: fields[0] as String,
      address: fields[1] as String,
      notes: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UpdateSchoolParam obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.notes)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateSchoolParamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
