import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  
  const Failure([this.message = 'An unexpected error occurred']);

  @override
  List<Object> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server failure occurred']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache failure occurred']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network failure occurred']);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = 'Database failure occurred']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failure occurred']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Resource not found']);
}

class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'Permission denied']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Unknown error occurred']);
}
