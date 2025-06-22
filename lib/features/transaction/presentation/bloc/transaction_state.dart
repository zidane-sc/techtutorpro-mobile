import 'package:equatable/equatable.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_entity.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_status.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<TransactionEntity> allTransactions;
  final List<TransactionEntity> filteredTransactions;
  final TransactionStatus? activeFilter;
  final String searchQuery;

  const TransactionLoaded({
    this.allTransactions = const [],
    this.filteredTransactions = const [],
    this.activeFilter,
    this.searchQuery = '',
  });

  TransactionLoaded copyWith({
    List<TransactionEntity>? allTransactions,
    List<TransactionEntity>? filteredTransactions,
    TransactionStatus? Function()? activeFilter,
    String? searchQuery,
  }) {
    return TransactionLoaded(
      allTransactions: allTransactions ?? this.allTransactions,
      filteredTransactions: filteredTransactions ?? this.filteredTransactions,
      activeFilter: activeFilter != null ? activeFilter() : this.activeFilter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        allTransactions,
        filteredTransactions,
        activeFilter,
        searchQuery,
      ];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError({required this.message});

  @override
  List<Object?> get props => [message];
}
