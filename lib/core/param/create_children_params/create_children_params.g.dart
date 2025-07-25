// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_children_params.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreateChildrenParamAdapter extends TypeAdapter<CreateChildrenParam> {
  @override
  final int typeId = 4;

  @override
  CreateChildrenParam read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreateChildrenParam(
      name: fields[0] as String,
      address: fields[1] as String,
      school: fields[2] as int,
      birthDate: fields[3] as String,
      notes: fields[4] as String?,
      phones: (fields[5] as List)
          .map((dynamic e) => (e as Map).cast<String, String>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, CreateChildrenParam obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.school)
      ..writeByte(3)
      ..write(obj.birthDate)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.phones);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateChildrenParamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
