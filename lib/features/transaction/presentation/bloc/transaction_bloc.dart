import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_entity.dart';
import 'package:techtutorpro/features/transaction/domain/usecases/get_transactions_usecase.dart';
import 'package:techtutorpro/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:techtutorpro/features/transaction/presentation/bloc/transaction_state.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactionsUseCase _getTransactionsUseCase;

  TransactionBloc({
    required GetTransactionsUseCase getTransactionsUseCase,
  })  : _getTransactionsUseCase = getTransactionsUseCase,
        super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<RefreshTransactions>(_onRefreshTransactions);
    on<FilterTransactions>(_onFilterTransactions);
    on<SearchTransactions>(_onSearchTransactions);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final transactions = await _getTransactionsUseCase();
      emit(TransactionLoaded(
        allTransactions: transactions,
        filteredTransactions: transactions,
      ));
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onRefreshTransactions(
    RefreshTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      final transactions = await _getTransactionsUseCase();
      emit(TransactionLoaded(
        allTransactions: transactions,
        filteredTransactions: transactions,
        activeFilter: null,
        searchQuery: '',
      ));
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  void _onFilterTransactions(
    FilterTransactions event,
    Emitter<TransactionState> emit,
  ) {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;

      List<TransactionEntity> filtered;
      if (event.status == null) {
        filtered = currentState.allTransactions;
      } else {
        filtered = currentState.allTransactions
            .where((t) => t.status == event.status)
            .toList();
      }

      emit(currentState.copyWith(
        filteredTransactions: filtered,
        activeFilter: () => event.status,
        searchQuery: '', // Reset search on filter change
      ));
    }
  }

  void _onSearchTransactions(
    SearchTransactions event,
    Emitter<TransactionState> emit,
  ) {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;

      final filtered = currentState.allTransactions.where((t) {
        final query = event.query.toLowerCase();
        final courseName = t.courseName.toLowerCase();

        final matchesQuery = courseName.contains(query);
        final matchesFilter = currentState.activeFilter == null ||
            t.status == currentState.activeFilter;

        return matchesQuery && matchesFilter;
      }).toList();

      emit(currentState.copyWith(
        filteredTransactions: filtered,
        searchQuery: event.query,
      ));
    }
  }
}
