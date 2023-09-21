// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfoDataAdapter extends TypeAdapter<UserInfoData> {
  @override
  final int typeId = 0;

  @override
  UserInfoData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfoData()
      ..email = fields[0] as String?
      ..displayName = fields[1] as String?
      ..photoURL = fields[2] as String?
      ..phoneNumber = fields[3] as String?
      ..uid = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, UserInfoData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.displayName)
      ..writeByte(2)
      ..write(obj.photoURL)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
