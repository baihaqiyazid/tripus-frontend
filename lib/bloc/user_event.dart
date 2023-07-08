part of 'user_bloc.dart';

abstract class UserEvent {}

class UserPostRegister extends UserEvent {
  final String name;
  final String email;
  final String password;

  UserPostRegister(this.name, this.email, this.password,);
}

class UserVerifyEvent extends UserEvent {
  final String otpCode;
  UserVerifyEvent(this.otpCode);
}

class ResetStateEvent extends UserEvent{}

