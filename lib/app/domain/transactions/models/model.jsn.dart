import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.jsn.g.dart';

@JsonSerializable()
class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.description,
    required this.merchant,
    required this.date,
    required this.currency,
    required this.category,
    required this.fromAccount,
    required this.toAccount,
  });

  final int id;
  final int userId;
  final DateTime date;
  final String merchant;
  final double amount;
  final String description;
  final String currency;
  final String category;

  @JsonKey(name: 'from_account')
  final String fromAccount;
  @JsonKey(name: 'to_account')
  final String toAccount;

  @override
  List<Object?> get props => [
    id,
    userId,
    date,
    merchant,
    amount,
    description,
    currency,
    category,
    fromAccount,
    toAccount,
  ];

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
