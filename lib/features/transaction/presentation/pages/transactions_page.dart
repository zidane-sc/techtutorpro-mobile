import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_entity.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_status.dart';
import 'package:techtutorpro/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:techtutorpro/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:techtutorpro/features/transaction/presentation/bloc/transaction_state.dart';
import 'package:techtutorpro/features/transaction/presentation/widgets/transaction_detail_sheet.dart';
import 'package:techtutorpro/features/transaction/presentation/widgets/transaction_filter_chips.dart';
import 'package:techtutorpro/features/transaction/presentation/widgets/transaction_list_card.dart';
import 'package:techtutorpro/features/transaction/presentation/widgets/transaction_search_bar.dart';
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

  void _showTransactionDetails(TransactionEntity transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TransactionDetailSheet(
          transaction: transaction, parentContext: context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Transaction',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
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
              child: _buildTransactionBody(state),
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

  Widget _buildTransactionBody(TransactionLoaded state) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    final totalSpent = state.allTransactions.fold<int>(
      0,
      (sum, item) =>
          item.status == TransactionStatus.completed ? sum + item.price : sum,
    );
    final completedCount = state.allTransactions
        .where((t) => t.status == TransactionStatus.completed)
        .length;
    final pendingCount = state.allTransactions
        .where((t) => t.status == TransactionStatus.pending)
        .length;
    final failedCount = state.allTransactions
        .where((t) => t.status == TransactionStatus.failed)
        .length;

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.8,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TransactionSummaryCard(
                      title: 'Total Spent',
                      value: currencyFormatter.format(totalSpent),
                      icon: Icons.wallet_outlined,
                      color: Colors.blueAccent,
                    ),
                    TransactionSummaryCard(
                      title: 'Completed',
                      value: completedCount.toString(),
                      icon: Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                    TransactionSummaryCard(
                      title: 'Pending',
                      value: pendingCount.toString(),
                      icon: Icons.hourglass_empty_outlined,
                      color: Colors.orange,
                    ),
                    TransactionSummaryCard(
                      title: 'Failed',
                      value: failedCount.toString(),
                      icon: Icons.cancel_outlined,
                      color: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TransactionSearchBar(
                  initialQuery: state.searchQuery,
                  onSearch: (query) {
                    context
                        .read<TransactionBloc>()
                        .add(SearchTransactions(query: query));
                  },
                ),
                const SizedBox(height: 16),
                TransactionFilterChips(
                  selectedStatus: state.activeFilter,
                  onSelected: (status) {
                    context
                        .read<TransactionBloc>()
                        .add(FilterTransactions(status: status));
                  },
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: state.filteredTransactions.isEmpty
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text('Tidak ada transaksi yang cocok.',
                          style: GoogleFonts.poppins()),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final transaction = state.filteredTransactions[index];
                      return TransactionListCard(
                        transaction: transaction,
                        onTap: () => _showTransactionDetails(transaction),
                      );
                    },
                    childCount: state.filteredTransactions.length,
                  ),
                ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }
}
