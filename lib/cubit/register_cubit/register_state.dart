part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFail extends RegisterState {
  String errMessage;
  RegisterFail({required this.errMessage});
}

class RegisterLoading extends RegisterState {}
