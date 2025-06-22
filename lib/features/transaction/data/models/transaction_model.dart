import 'package:techtutorpro/features/transaction/domain/entities/transaction_entity.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_status.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.courseId,
    required super.courseName,
    required super.amount,
    required super.date,
    required super.status,
    super.coverImage,
    super.paymentMethod,
  }) : super(price: amount);

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      courseId: json['courseId'],
      courseName: json['courseName'],
      coverImage: json['coverImage'] as String?,
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      status: TransactionStatus.fromString(json['status']),
      paymentMethod: json['paymentMethod'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'courseName': courseName,
      'coverImage': coverImage,
      'amount': amount,
      'date': date.toIso8601String(),
      'status': status.name,
      'paymentMethod': paymentMethod,
    };
  }
}
