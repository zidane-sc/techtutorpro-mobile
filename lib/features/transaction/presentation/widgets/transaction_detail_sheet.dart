import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:techtutorpro/core/services/download_service.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_entity.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_status.dart';
import 'package:techtutorpro/injection.dart';
import 'package:techtutorpro/features/payment/presentation/pages/payment_summary_page.dart';
import 'package:techtutorpro/features/courses/domain/usecases/get_course_detail_usecase.dart';
import 'package:go_router/go_router.dart';

class TransactionDetailSheet extends StatefulWidget {
  final TransactionEntity transaction;
  final BuildContext parentContext;
  const TransactionDetailSheet({
    Key? key,
    required this.transaction,
    required this.parentContext,
  }) : super(key: key);

  @override
  State<TransactionDetailSheet> createState() => _TransactionDetailSheetState();
}

class _TransactionDetailSheetState extends State<TransactionDetailSheet> {
  bool _isDownloading = false;

  Future<void> _downloadInvoice() async {
    setState(() => _isDownloading = true);
    try {
      final downloadService = getIt<DownloadService>();
      const assetPath = 'assets/dummy/payment-receipt.pdf';
      final fileName = 'Invoice_${widget.transaction.id.substring(0, 8)}.pdf';

      await downloadService.saveAndOpenAssetFromBundle(assetPath, fileName);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invoice opened successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open invoice: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[700] : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _StatusBadge(status: widget.transaction.status),
          const SizedBox(height: 16),
          Text(
            widget.transaction.courseName,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildDetailRow(
            icon: Icons.receipt_long_outlined,
            label: 'Transaction ID',
            value: widget.transaction.id,
          ),
          _buildDetailRow(
            icon: Icons.calendar_today_outlined,
            label: 'Date',
            value: DateFormat('d MMMM yyyy, HH:mm')
                .format(widget.transaction.date),
          ),
          _buildDetailRow(
            icon: Icons.credit_card_outlined,
            label: 'Payment Method',
            value: widget.transaction.paymentMethod ?? '-',
          ),
          const SizedBox(height: 12),
          Divider(color: isDark ? Colors.grey[800] : Colors.grey[200]),
          const SizedBox(height: 12),
          _buildDetailRow(
            icon: Icons.monetization_on_outlined,
            label: 'Total Price',
            value: NumberFormat.currency(
              locale: 'id_ID',
              symbol: 'Rp ',
              decimalDigits: 0,
            ).format(widget.transaction.price),
            isHighlighted: true,
          ),
          const SizedBox(height: 24),
          ..._buildActionButtons(),
        ],
      ),
    );
  }

  List<Widget> _buildActionButtons() {
    switch (widget.transaction.status) {
      case TransactionStatus.completed:
        return [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.school_outlined),
              label: const Text('Go to Course'),
              onPressed: () {
                Navigator.pop(context); // Pop sheet
                widget.parentContext
                    .push('/dashboard/course/${widget.transaction.courseId}');
              },
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              icon: _isDownloading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.download_outlined),
              label:
                  Text(_isDownloading ? 'Downloading...' : 'Download Invoice'),
              onPressed: _isDownloading ? null : _downloadInvoice,
            ),
          ),
        ];
      case TransactionStatus.pending:
        return [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.payment_outlined),
              label: const Text('Complete Payment'),
              onPressed: () async {
                Navigator.pop(context); // Close the bottom sheet
                showDialog(
                  context: widget.parentContext,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
                final result = await getIt<GetCourseDetailUseCase>()(
                    widget.transaction.courseId);
                Navigator.of(widget.parentContext)
                    .pop(); // Close loading dialog
                result.fold(
                  (failure) => showDialog(
                    context: widget.parentContext,
                    builder: (_) => AlertDialog(
                      title: const Text('Error'),
                      content: Text(failure),
                      actions: [
                        TextButton(
                            onPressed: () =>
                                Navigator.pop(widget.parentContext),
                            child: const Text('OK'))
                      ],
                    ),
                  ),
                  (course) => widget.parentContext
                      .push('/dashboard/payment-summary', extra: course),
                );
              },
            ),
          ),
        ];
      case TransactionStatus.failed:
        return [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.refresh_outlined),
              label: const Text('Retry Payment'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () async {
                Navigator.pop(context); // Close the bottom sheet
                showDialog(
                  context: widget.parentContext,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
                final result = await getIt<GetCourseDetailUseCase>()(
                    widget.transaction.courseId);
                Navigator.of(widget.parentContext)
                    .pop(); // Close loading dialog
                result.fold(
                  (failure) => showDialog(
                    context: widget.parentContext,
                    builder: (_) => AlertDialog(
                      title: const Text('Error'),
                      content: Text(failure),
                      actions: [
                        TextButton(
                            onPressed: () =>
                                Navigator.pop(widget.parentContext),
                            child: const Text('OK'))
                      ],
                    ),
                  ),
                  (course) => widget.parentContext
                      .push('/dashboard/payment-summary', extra: course),
                );
              },
            ),
          ),
        ];
    }
  }

  Widget _buildDetailRow(
      {required IconData icon,
      required String label,
      required String value,
      bool isHighlighted = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon,
              size: 20, color: isDark ? Colors.grey[400] : Colors.grey[600]),
          const SizedBox(width: 16),
          Text(label, style: GoogleFonts.poppins()),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
              color: isHighlighted ? Theme.of(context).primaryColor : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final TransactionStatus status;
  const _StatusBadge({required this.status});

  Color _getColor() {
    switch (status) {
      case TransactionStatus.completed:
        return Colors.green;
      case TransactionStatus.pending:
        return Colors.orange;
      case TransactionStatus.failed:
        return Colors.red;
    }
  }

  IconData _getIcon() {
    switch (status) {
      case TransactionStatus.completed:
        return Icons.check_circle_outline;
      case TransactionStatus.pending:
        return Icons.hourglass_bottom_outlined;
      case TransactionStatus.failed:
        return Icons.cancel_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getIcon(), color: _getColor(), size: 16),
          const SizedBox(width: 8),
          Text(
            status.displayName,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: _getColor(),
            ),
          ),
        ],
      ),
    );
  }
}
