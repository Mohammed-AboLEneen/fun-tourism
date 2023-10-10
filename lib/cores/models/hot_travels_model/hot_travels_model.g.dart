// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_travels_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HotTravelModelAdapter extends TypeAdapter<HotTravelModel> {
  @override
  final int typeId = 2;

  @override
  HotTravelModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HotTravelModel()
      ..description = fields[0] as String?
      ..price = fields[1] as String?
      ..availablePlaces = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, HotTravelModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.availablePlaces);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotTravelModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
