// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account.jsn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => UserAccount(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  name: json['name'] as String,
  biometricEnabled: json['biometricEnabled'] as bool,
);

Map<String, dynamic> _$UserAccountToJson(UserAccount instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'biometricEnabled': instance.biometricEnabled,
};
