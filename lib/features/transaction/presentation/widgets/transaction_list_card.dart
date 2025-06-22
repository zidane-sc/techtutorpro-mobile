import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_entity.dart';
import 'package:techtutorpro/features/transaction/presentation/widgets/transaction_detail_sheet.dart';

class TransactionListCard extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionListCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final statusStyle = _getStatusStyle(transaction.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shadowColor: Theme.of(context).shadowColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => TransactionDetailSheet(transaction: transaction),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Status Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: statusStyle['color']!.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  statusStyle['icon'],
                  color: statusStyle['color'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // Transaction Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.courseName,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('d MMMM yyyy').format(transaction.date),
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Price
              Text(
                NumberFormat.currency(
                  locale: 'id_ID',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(transaction.price),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: statusStyle['color'],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getStatusStyle(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return {'color': Colors.green, 'icon': Icons.check_circle_rounded};
      case 'pending':
        return {
          'color': Colors.orangeAccent,
          'icon': Icons.hourglass_bottom_rounded
        };
      case 'failed':
        return {'color': Colors.redAccent, 'icon': Icons.cancel_rounded};
      default:
        return {'color': Colors.grey, 'icon': Icons.help_rounded};
    }
  }
}
