import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String transactionId;
  final String courseName;
  final DateTime date;
  final int price;
  final String status;
  final String paymentMethod;

  const TransactionEntity({
    required this.transactionId,
    required this.courseName,
    required this.date,
    required this.price,
    required this.status,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props =>
      [transactionId, courseName, date, price, status, paymentMethod];
}
