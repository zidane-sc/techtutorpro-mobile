import 'package:equatable/equatable.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_status.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String courseId;
  final String courseName;
  final String? coverImage;
  final int amount;
  final DateTime date;
  final int price;
  final TransactionStatus status;
  final String? paymentMethod;

  const TransactionEntity({
    required this.id,
    required this.courseId,
    required this.courseName,
    this.coverImage,
    required this.amount,
    required this.date,
    required this.price,
    required this.status,
    this.paymentMethod,
  });

  @override
  List<Object?> get props => [
        id,
        courseId,
        courseName,
        coverImage,
        amount,
        date,
        price,
        status,
        paymentMethod,
      ];
}
