part of 'log_bloc.dart';

@immutable
abstract class LogEvent extends Equatable  {

  @override
  List<Object> get props => [];

}

class NameChanged extends LogEvent {
  final String Name;

  NameChanged({required this.Name});

  @override
  String toString() => 'NameChanged { Name :$Name }';

  @override
  List<Object> get props => [Name];
}


class PasswordChanged extends LogEvent {
  final String password;

  PasswordChanged({required this.password});

  @override
  String toString() => 'PasswordChanged { pass :$password }';

  @override
  List<Object> get props => [password];
}


class Submitted extends LogEvent {

  Submitted();

}


class showpassword extends LogEvent {

bool show=false;
showpassword({required this.show});

@override
String toString() => 'showpassword { show :$show }';

@override
List<Object> get props => [show];
}

