import 'package:equatable/equatable.dart';

abstract class Errors extends Equatable{
  @override
  List<Object?> get props => [];
}

class ServerErrors extends Errors{}

class LocalErrors extends Errors{}