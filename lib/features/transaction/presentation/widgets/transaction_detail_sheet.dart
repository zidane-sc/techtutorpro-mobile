import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtutorpro/core/services/download_service.dart';
import 'package:techtutorpro/features/transaction/domain/entities/transaction_entity.dart';

class TransactionDetailSheet extends StatefulWidget {
  final TransactionEntity transaction;
  const TransactionDetailSheet({super.key, required this.transaction});

  @override
  State<TransactionDetailSheet> createState() => _TransactionDetailSheetState();
}

class _TransactionDetailSheetState extends State<TransactionDetailSheet> {
  bool _isDownloading = false;

  Future<void> _downloadReceipt() async {
    setState(() {
      _isDownloading = true;
    });

    try {
      const url =
          'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
      final fileName = 'receipt-${widget.transaction.transactionId}.pdf';

      await DownloadService().downloadAndOpenFile(url, fileName);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Receipt downloaded successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'Download failed';
        if (e.toString().contains('Storage permission denied')) {
          errorMessage =
              'Storage permission is required to download files. Please grant permission in Settings.';
        } else if (e.toString().contains('Could not open')) {
          errorMessage =
              'File downloaded but could not be opened. Check your Downloads folder.';
        } else {
          errorMessage = 'Download failed: ${e.toString()}';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Detail Transaksi',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'ID: ${widget.transaction.transactionId}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 24),
              _buildDetailRow(
                context,
                icon: Icons.book_outlined,
                title: 'Kursus',
                value: widget.transaction.courseName,
              ),
              _buildDetailRow(
                context,
                icon: Icons.calendar_today_outlined,
                title: 'Tanggal',
                value: DateFormat('d MMMM yyyy, HH:mm')
                    .format(widget.transaction.date),
              ),
              _buildDetailRow(
                context,
                icon: Icons.payment_outlined,
                title: 'Metode Pembayaran',
                value: widget.transaction.paymentMethod,
              ),
              _buildDetailRow(
                context,
                icon: Icons.monetization_on_outlined,
                title: 'Total Pembayaran',
                value: NumberFormat.currency(
                  locale: 'id_ID',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(widget.transaction.price),
                isHighlighted: true,
              ),
              _buildDetailRow(
                context,
                icon: Icons.info_outline,
                title: 'Status',
                value: widget.transaction.status,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Tutup',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isDownloading ? null : _downloadReceipt,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: _isDownloading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.download_for_offline_outlined),
                      label: Text(
                        _isDownloading ? 'Downloading...' : 'Download',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    bool isHighlighted = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.grey[700],
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              color: isHighlighted
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}
