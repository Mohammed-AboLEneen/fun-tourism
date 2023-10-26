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
      ..userInfoData = fields[0] as UserInfoData
      ..friends = (fields[1] as List?)?.cast<dynamic>()
      ..chats = (fields[2] as List?)?.cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, UserAppData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userInfoData)
      ..writeByte(1)
      ..write(obj.friends)
      ..writeByte(2)
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
