import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.jsn.g.dart';

@JsonSerializable()
class UserSettings extends Equatable {
  const UserSettings({
    required this.userId,
    required this.notificationsEnabled,
    required this.limit,
    required this.currency,
    required this.biometricEnabled,
  });

  final int userId;
  @JsonKey(name: 'notifications_enabled')
  final bool notificationsEnabled;
  final int limit;
  final String currency;
  @JsonKey(name: 'biometric_enabled')
  final bool biometricEnabled;

  @override
  List<Object?> get props => [userId, notificationsEnabled, limit, currency, biometricEnabled];

  factory UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$UserSettingsToJson(this);
}
