// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_app_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAppDataAdapter extends TypeAdapter<UserAppData> {
  @override
  final int typeId = 1;

  @override
  UserAppData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserAppData()
      ..email = fields[0] as String?
      ..phoneNumber = fields[1] as String?
      ..displayName = fields[2] as String?
      ..photoURL = fields[3] as String?
      ..friends = (fields[4] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          ?.toList()
      ..chats = (fields[5] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          ?.toList();
  }

  @override
  void write(BinaryWriter writer, UserAppData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.photoURL)
      ..writeByte(4)
      ..write(obj.friends)
      ..writeByte(5)
      ..write(obj.chats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAppDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
