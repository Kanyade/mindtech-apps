// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account.jsn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => UserAccount(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  name: json['name'] as String,
  profilePicture: json['profile_picture'] as String,
);

Map<String, dynamic> _$UserAccountToJson(UserAccount instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'profile_picture': instance.profilePicture,
};
