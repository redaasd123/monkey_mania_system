// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'children_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChildrenEntityAdapter extends TypeAdapter<ChildrenEntity> {
  @override
  final int typeId = 1;

  @override
  ChildrenEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChildrenEntity(
      id: fields[0] as num?,
      name: fields[1] as String?,
      birthDate: fields[2] as String?,
      age: fields[3] as AgeEntity?,
      notes: fields[4] as String?,
      address: fields[5] as String?,
      isActive: fields[6] as bool?,
      specialNeeds: fields[7] as bool?,
      created: fields[8] as String?,
      updated: fields[9] as String?,
      createdBy: fields[10] as String?,
      school: fields[11] as num?,
      childPhoneNumbersSet: (fields[12] as List?)?.cast<PhoneEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChildrenEntity obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.birthDate)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.isActive)
      ..writeByte(7)
      ..write(obj.specialNeeds)
      ..writeByte(8)
      ..write(obj.created)
      ..writeByte(9)
      ..write(obj.updated)
      ..writeByte(10)
      ..write(obj.createdBy)
      ..writeByte(11)
      ..write(obj.school)
      ..writeByte(12)
      ..write(obj.childPhoneNumbersSet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChildrenEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
