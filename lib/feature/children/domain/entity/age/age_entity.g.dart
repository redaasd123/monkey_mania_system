// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'age_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgeEntityAdapter extends TypeAdapter<AgeEntity> {
  @override
  final int typeId = 2;

  @override
  AgeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AgeEntity(
      years: fields[0] as num?,
      months: fields[1] as num?,
      days: fields[2] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, AgeEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.years)
      ..writeByte(1)
      ..write(obj.months)
      ..writeByte(2)
      ..write(obj.days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
