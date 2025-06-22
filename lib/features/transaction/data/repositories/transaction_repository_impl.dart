import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_entity.dart';
import 'package:techtutorpro/features/transaction/domain/repositories/transaction_repository.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDataSource dataSource;

  TransactionRepositoryImpl({required this.dataSource});

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    try {
      final transactions = await dataSource.getTransactions();
      return transactions;
    } catch (e) {
      throw Exception('Failed to load transactions: $e');
    }
  }
}
