import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.jsn.g.dart';

@JsonSerializable()
class UserProfile extends Equatable {
  const UserProfile({required this.id, required this.name});

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
