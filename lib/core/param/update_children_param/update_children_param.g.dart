// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_children_param.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UpdateChildrenParamAdapter extends TypeAdapter<UpdateChildrenParam> {
  @override
  final int typeId = 5;

  @override
  UpdateChildrenParam read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UpdateChildrenParam(
      id: fields[2] as int,
      phoneNumber: (fields[5] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      name: fields[0] as String,
      address: fields[1] as String?,
      school: fields[3] as int?,
      birthDate: fields[4] as String,
      notes: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UpdateChildrenParam obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.school)
      ..writeByte(4)
      ..write(obj.birthDate)
      ..writeByte(5)
      ..write(obj.phoneNumber)
      ..writeByte(6)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateChildrenParamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
