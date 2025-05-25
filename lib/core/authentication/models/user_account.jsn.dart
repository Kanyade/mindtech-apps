import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_account.jsn.g.dart';

@JsonSerializable()
class UserAccount extends Equatable {
  const UserAccount({required this.id, required this.email, required this.name, required this.profilePicture});

  final int id;
  final String email;
  final String name;
  @JsonKey(name: 'profile_picture')
  final String profilePicture;

  @override
  List<Object?> get props => [id, email, name, profilePicture];

  factory UserAccount.fromJson(Map<String, dynamic> json) => _$UserAccountFromJson(json);
  Map<String, dynamic> toJson() => _$UserAccountToJson(this);
}
