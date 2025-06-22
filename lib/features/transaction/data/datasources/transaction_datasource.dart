import 'package:techtutorpro/features/transaction/data/models/transaction_model.dart';
import 'package:injectable/injectable.dart';

abstract class TransactionDataSource {
  Future<List<TransactionModel>> getTransactions();
}

@LazySingleton(as: TransactionDataSource)
class TransactionDataSourceImpl implements TransactionDataSource {
  @override
  Future<List<TransactionModel>> getTransactions() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock data
    return [
      TransactionModel(
        transactionId: 'TTP-12345-ABCDE',
        courseName: 'Flutter Development Masterclass',
        date: DateTime.parse('2024-01-15'),
        price: 299000,
        status: 'Completed',
        paymentMethod: 'Credit Card',
      ),
      TransactionModel(
        transactionId: 'TTP-67890-FGHIJ',
        courseName: 'React Native Fundamentals',
        date: DateTime.parse('2024-01-10'),
        price: 199000,
        status: 'Completed',
        paymentMethod: 'GoPay',
      ),
      TransactionModel(
        transactionId: 'TTP-11223-KLMNO',
        courseName: 'UI/UX Design Principles',
        date: DateTime.parse('2024-01-05'),
        price: 149000,
        status: 'Completed',
        paymentMethod: 'Credit Card',
      ),
      TransactionModel(
        transactionId: 'TTP-44556-PQRST',
        courseName: 'Backend Development with Node.js',
        date: DateTime.parse('2023-12-28'),
        price: 249000,
        status: 'Completed',
        paymentMethod: 'Bank Transfer',
      ),
      TransactionModel(
        transactionId: 'TTP-77889-UVWXY',
        courseName: 'Machine Learning Basics',
        date: DateTime.parse('2023-12-20'),
        price: 399000,
        status: 'Pending',
        paymentMethod: 'Bank Transfer',
      ),
      TransactionModel(
        transactionId: 'TTP-10111-ZABCD',
        courseName: 'DevOps & CI/CD Pipeline',
        date: DateTime.parse('2023-12-15'),
        price: 179000,
        status: 'Failed',
        paymentMethod: 'Credit Card',
      ),
      TransactionModel(
        transactionId: 'TTP-21314-EFGHI',
        courseName: 'Database Design & SQL',
        date: DateTime.parse('2023-12-10'),
        price: 129000,
        status: 'Completed',
        paymentMethod: 'GoPay',
      ),
      TransactionModel(
        transactionId: 'TTP-51617-JKLMN',
        courseName: 'Mobile App Security',
        date: DateTime.parse('2023-12-05'),
        price: 159000,
        status: 'Completed',
        paymentMethod: 'Bank Transfer',
      ),
    ];
  }
}
