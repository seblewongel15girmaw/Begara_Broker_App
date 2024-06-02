import 'package:dartz/dartz.dart';

import '../error/errors.dart';

abstract class UseCase<Type, Params>{
  Future<Either<Errors,Type>> call(Params param);
}

abstract class SocketUseCase<Type,Params>{
  Either<Errors,Type> call (Params param);
}