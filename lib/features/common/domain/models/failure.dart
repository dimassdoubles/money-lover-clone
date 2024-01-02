import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  const Failure({this.message = ""});

  @override
  List<Object?> get props => [
        message,
      ];
}

class NetworkFailure extends Failure {}

class ClientFailure extends Failure {}

class ServerFailure extends Failure {}
