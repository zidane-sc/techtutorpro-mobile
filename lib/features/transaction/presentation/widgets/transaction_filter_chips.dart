import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_status.dart';

class TransactionFilterChips extends StatelessWidget {
  final TransactionStatus? selectedStatus;
  final Function(TransactionStatus? status) onSelected;

  const TransactionFilterChips({
    super.key,
    required this.selectedStatus,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildChip(context, null, 'All', isDark),
          const SizedBox(width: 8),
          _buildChip(context, TransactionStatus.completed, 'Completed', isDark),
          const SizedBox(width: 8),
          _buildChip(context, TransactionStatus.pending, 'Pending', isDark),
          const SizedBox(width: 8),
          _buildChip(context, TransactionStatus.failed, 'Failed', isDark),
        ],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context,
    TransactionStatus? status,
    String label,
    bool isDark,
  ) {
    final isSelected = selectedStatus == status;
    final selectedColor = Theme.of(context).primaryColor;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(status),
      labelStyle: GoogleFonts.poppins(
        color: isSelected
            ? Colors.white
            : (isDark ? Colors.white70 : Colors.black87),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
      ),
      backgroundColor: isDark ? Colors.grey[850] : Colors.grey[200],
      selectedColor: selectedColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected
              ? selectedColor
              : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
        ),
      ),
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
