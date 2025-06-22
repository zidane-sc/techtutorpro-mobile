import 'package:techtutorpro/features/transaction/data/models/transaction_model.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_status.dart';

abstract class TransactionDataSource {
  Future<List<TransactionModel>> getTransactions();
}

@LazySingleton(as: TransactionDataSource)
class TransactionDataSourceImpl implements TransactionDataSource {
  @override
  Future<List<TransactionModel>> getTransactions() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy data
    final List<Map<String, dynamic>> dummyData = [
      {
        'id': 'trx001',
        'courseId': '1',
        'courseName': 'Flutter for Beginners: From Zero to Hero',
        'coverImage': 'https://picsum.photos/400/250?random=1',
        'amount': 100000,
        'date': '2023-10-26T10:00:00Z',
        'status': 'completed',
        'paymentMethod': 'Credit Card',
      },
      {
        'id': 'trx002',
        'courseId': '2',
        'courseName': 'Belajar Python: Dari Dasar hingga Mahir',
        'coverImage': 'https://picsum.photos/400/250?random=2',
        'amount': 75000,
        'date': '2023-10-25T14:30:00Z',
        'status': 'completed',
        'paymentMethod': 'PayPal',
      },
      {
        'id': 'trx003',
        'courseId': '3',
        'courseName': 'Advanced JavaScript Concepts',
        'coverImage': 'https://picsum.photos/400/250?random=3',
        'amount': 120000,
        'date': '2023-10-24T18:45:00Z',
        'status': 'pending',
        'paymentMethod': 'Bank Transfer',
      },
      {
        'id': 'trx004',
        'courseId': '4',
        'courseName': 'Complete Web Development Bootcamp',
        'coverImage': 'https://picsum.photos/400/250?random=4',
        'amount': 250000,
        'date': '2023-10-22T09:15:00Z',
        'status': 'failed',
        'paymentMethod': 'Credit Card',
      },
      {
        'id': 'trx005',
        'courseId': '5',
        'courseName': 'UI/UX Design with Figma',
        'coverImage': 'https://picsum.photos/400/250?random=5',
        'amount': 90000,
        'date': '2023-10-20T11:00:00Z',
        'status': 'completed',
        'paymentMethod': 'GoPay',
      },
    ];

    return dummyData.map((json) => TransactionModel.fromJson(json)).toList();
  }
}
