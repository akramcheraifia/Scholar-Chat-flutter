part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFail extends LoginState {
  String errMessage;
  LoginFail({required this.errMessage});
}

class LoginLoading extends LoginState {}
