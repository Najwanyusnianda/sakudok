import 'package:fpdart/fpdart.dart';
import 'package:equatable/equatable.dart';
import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();
  
  @override
  List<Object> get props => [];
}
