class FileServiceException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const FileServiceException(
    this.message, {
    this.code,
    this.originalError,
  });

  @override
  String toString() {
    if (code != null) {
      return 'FileServiceException [$code]: $message';
    }
    return 'FileServiceException: $message';
  }
}
