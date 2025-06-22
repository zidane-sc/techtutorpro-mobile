import 'package:equatable/equatable.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_status.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class LoadTransactions extends TransactionEvent {
  const LoadTransactions();
}

class RefreshTransactions extends TransactionEvent {
  const RefreshTransactions();
}

class FilterTransactions extends TransactionEvent {
  final TransactionStatus? status;

  const FilterTransactions({this.status});

  @override
  List<Object?> get props => [status];
}

class SearchTransactions extends TransactionEvent {
  final String query;

  const SearchTransactions({required this.query});

  @override
  List<Object?> get props => [query];
}

class GetCourseForPayment extends TransactionEvent {
  final String courseId;

  const GetCourseForPayment({required this.courseId});

  @override
  List<Object?> get props => [courseId];
}
