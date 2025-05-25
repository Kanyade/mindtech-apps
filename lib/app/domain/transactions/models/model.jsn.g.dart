// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.jsn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  amount: (json['amount'] as num).toDouble(),
  description: json['description'] as String,
  merchant: json['merchant'] as String,
  date: DateTime.parse(json['date'] as String),
  currency: json['currency'] as String,
  category: json['category'] as String,
  fromAccount: json['from_account'] as String,
  toAccount: json['to_account'] as String,
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'date': instance.date.toIso8601String(),
  'merchant': instance.merchant,
  'amount': instance.amount,
  'description': instance.description,
  'currency': instance.currency,
  'category': instance.category,
  'from_account': instance.fromAccount,
  'to_account': instance.toAccount,
};
