// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.jsn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) => UserSettings(
  userId: (json['userId'] as num).toInt(),
  notificationsEnabled: json['notifications_enabled'] as bool,
  limit: (json['limit'] as num).toInt(),
  currency: json['currency'] as String,
  biometricEnabled: json['biometric_enabled'] as bool,
);

Map<String, dynamic> _$UserSettingsToJson(UserSettings instance) => <String, dynamic>{
  'userId': instance.userId,
  'notifications_enabled': instance.notificationsEnabled,
  'limit': instance.limit,
  'currency': instance.currency,
  'biometric_enabled': instance.biometricEnabled,
};
