import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:techtutorpro/core/services/download_service.dart';
import 'package:techtutorpro/features/courses/domain/entities/certificate_entity.dart';
import 'package:techtutorpro/injection.dart';

class CertificatePage extends StatefulWidget {
  final CertificateEntity certificate;

  const CertificatePage({super.key, required this.certificate});

  @override
  State<CertificatePage> createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  bool _isDownloading = false;

  Future<void> _downloadCertificate() async {
    setState(() {
      _isDownloading = true;
    });

    try {
      final downloadService = getIt<DownloadService>();
      const assetPath = 'assets/dummy/certificate.pdf';
      final fileName =
          'TechTutorPro_Certificate_${widget.certificate.courseTitle.replaceAll(' ', '_')}.pdf';

      await downloadService.saveAndOpenAssetFromBundle(assetPath, fileName);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Certificate opened successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e')),
      );
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificate of Completion'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          _isDownloading
              ? const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Center(
                      child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 3))),
                )
              : IconButton(
                  onPressed: _downloadCertificate,
                  icon: const Icon(Icons.download_for_offline_outlined),
                  tooltip: 'Download Certificate',
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.amber.shade700, width: 4),
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Colors.yellow.shade50, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Certificate of Completion',
                textAlign: TextAlign.center,
                style: GoogleFonts.satisfy(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'This is to certify that',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              Text(
                widget.certificate.userName,
                style: GoogleFonts.lato(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'has successfully completed the course',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              Text(
                widget.certificate.courseTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSignatureLine(
                    'Date',
                    DateFormat.yMMMMd()
                        .format(widget.certificate.completionDate),
                  ),
                  _buildSignatureLine('Issued by', 'TechTutor Pro',
                      isHandwriting: true),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Certificate ID: ${widget.certificate.certificateId}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignatureLine(String label, String value,
      {bool isHandwriting = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: isHandwriting
              ? GoogleFonts.satisfy(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)
              : const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 16),
        ),
        const SizedBox(height: 4),
        Container(width: 120, height: 1, color: Colors.black54),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
