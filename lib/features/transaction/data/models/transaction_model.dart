import 'package:techtutorpro/features/transaction/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.transactionId,
    required super.courseName,
    required super.date,
    required super.price,
    required super.status,
    required super.paymentMethod,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionId: json['transactionId'] as String,
      courseName: json['courseName'] as String,
      date: DateTime.parse(json['date'] as String),
      price: json['price'] as int,
      status: json['status'] as String,
      paymentMethod: json['paymentMethod'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'courseName': courseName,
      'date': date.toIso8601String(),
      'price': price,
      'status': status,
      'paymentMethod': paymentMethod,
    };
  }
}
