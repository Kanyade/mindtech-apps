import 'package:json_annotation/json_annotation.dart';

part 'get_account_request.jsn.g.dart';

@JsonSerializable(createFactory: false)
class GetAccountRequest {
  const GetAccountRequest({required this.email});

  final String email;

  Map<String, dynamic> toJson() => _$GetAccountRequestToJson(this);
}
