enum TransactionStatus {
  completed,
  pending,
  failed;

  String get displayName {
    switch (this) {
      case TransactionStatus.completed:
        return 'Completed';
      case TransactionStatus.pending:
        return 'Pending';
      case TransactionStatus.failed:
        return 'Failed';
    }
  }

  static TransactionStatus fromString(String status) {
    return TransactionStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == status.toLowerCase(),
      orElse: () => TransactionStatus.pending,
    );
  }
}
