// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_news_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentNewsModelAdapter extends TypeAdapter<RecentNewsModel> {
  @override
  final int typeId = 3;

  @override
  RecentNewsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentNewsModel()
      ..image = fields[0] as Uint8List?
      ..title = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, RecentNewsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentNewsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
