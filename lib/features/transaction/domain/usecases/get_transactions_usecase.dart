import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_entity.dart';
import 'package:techtutorpro/features/transaction/domain/repositories/transaction_repository.dart';

@lazySingleton
class GetTransactionsUseCase {
  final TransactionRepository _repository;

  GetTransactionsUseCase(this._repository);

  Future<List<TransactionEntity>> call() async {
    return _repository.getTransactions();
  }
}
