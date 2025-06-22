import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
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
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final transactions = await _getTransactionsUseCase();
      emit(TransactionLoaded(transactions: transactions));
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
      emit(TransactionLoaded(transactions: transactions));
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }
}
