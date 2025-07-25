// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhoneEntityAdapter extends TypeAdapter<PhoneEntity> {
  @override
  final int typeId = 3;

  @override
  PhoneEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhoneEntity(
      phoneNumber: fields[0] as String?,
      relationship: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PhoneEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.phoneNumber)
      ..writeByte(1)
      ..write(obj.relationship);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
