import 'package:json_annotation/json_annotation.dart';

part 'get_settings_request.jsn.g.dart';

@JsonSerializable(createFactory: false)
class GetSettingsRequest {
  const GetSettingsRequest({required this.userId});

  final int userId;

  Map<String, dynamic> toJson() => _$GetSettingsRequestToJson(this);
}
