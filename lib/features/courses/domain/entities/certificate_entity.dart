import 'package:equatable/equatable.dart';

class CertificateEntity extends Equatable {
  final String courseTitle;
  final String userName;
  final DateTime completionDate;
  final String certificateId;

  const CertificateEntity({
    required this.courseTitle,
    required this.userName,
    required this.completionDate,
    required this.certificateId,
  });

  @override
  List<Object?> get props =>
      [courseTitle, userName, completionDate, certificateId];
}
