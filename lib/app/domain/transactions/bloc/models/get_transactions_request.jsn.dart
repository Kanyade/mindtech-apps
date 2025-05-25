import 'package:json_annotation/json_annotation.dart';

part 'get_transactions_request.jsn.g.dart';

@JsonSerializable(createFactory: false)
class GetTransactionsRequest {
  const GetTransactionsRequest({required this.userId});

  final int userId;

  Map<String, dynamic> toJson() => _$GetTransactionsRequestToJson(this);
}
