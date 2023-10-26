// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_content_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageContentModelAdapter extends TypeAdapter<MessageContentModel> {
  @override
  final int typeId = 4;

  @override
  MessageContentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageContentModel()
      ..time = fields[0] as String?
      ..message = fields[1] as String?
      ..receiverId = fields[2] as String?
      ..senderId = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, MessageContentModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.receiverId)
      ..writeByte(3)
      ..write(obj.senderId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageContentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
