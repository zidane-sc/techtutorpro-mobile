import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_entity.dart';
import 'package:techtutorpro/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:techtutorpro/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:techtutorpro/features/transaction/presentation/bloc/transaction_state.dart';
import 'package:techtutorpro/features/transaction/presentation/widgets/transaction_list_card.dart';
import 'package:techtutorpro/features/transaction/presentation/widgets/transaction_summary_card.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(const LoadTransactions());
  }

  Future<void> _refreshTransactions() async {
    context.read<TransactionBloc>().add(const RefreshTransactions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Transaksi',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [],
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TransactionError) {
            return Center(
              child:
                  Text('Error: ${state.message}', style: GoogleFonts.poppins()),
            );
          }

          if (state is TransactionLoaded) {
            return RefreshIndicator(
              onRefresh: _refreshTransactions,
              child: _buildTransactionBody(state.transactions),
            );
          }

          return Center(
            child:
                Text('Tidak ada data transaksi.', style: GoogleFonts.poppins()),
          );
        },
      ),
    );
  }

  Widget _buildTransactionBody(List<TransactionEntity> transactions) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    final totalSpent = transactions.fold<int>(
      0,
      (sum, item) =>
          item.status.toLowerCase() == 'completed' ? sum + item.price : sum,
    );
    final completedCount =
        transactions.where((t) => t.status.toLowerCase() == 'completed').length;
    final pendingCount =
        transactions.where((t) => t.status.toLowerCase() == 'pending').length;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              TransactionSummaryCard(
                title: 'Total Pengeluaran',
                value: currencyFormatter.format(totalSpent),
                icon: Icons.wallet_outlined,
                color: Colors.blueAccent,
              ),
              TransactionSummaryCard(
                title: 'Total Transaksi',
                value: transactions.length.toString(),
                icon: Icons.receipt_long_outlined,
                color: Colors.orangeAccent,
              ),
              TransactionSummaryCard(
                title: 'Selesai',
                value: completedCount.toString(),
                icon: Icons.check_circle_outline,
                color: Colors.green,
              ),
              TransactionSummaryCard(
                title: 'Menunggu',
                value: pendingCount.toString(),
                icon: Icons.hourglass_empty_outlined,
                color: Colors.amber,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Detail Transaksi',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          if (transactions.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text('Tidak ada histori transaksi.',
                    style: GoogleFonts.poppins()),
              ),
            )
          else
            ListView.builder(
              itemCount: transactions.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return TransactionListCard(transaction: transaction);
              },
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
