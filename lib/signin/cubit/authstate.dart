import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AuthState {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final GoogleSignInAccount user;
  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthSuccessFacebook extends AuthState {
  final Map<String, dynamic> userData;
  AuthSuccessFacebook(this.userData);
}

class EmailSentSuccess extends AuthState {}

class CodeVerifiedSuccess extends AuthState {}

class PasswordSentSuccess extends AuthState {}
class AuthAuthenticated extends AuthState {//pour la reussite de enregister un utilisateur dans google ou facebook
  final Map<String, dynamic> user;
  AuthAuthenticated(this.user);
  @override
  List<Object?> get props => [user];
}
class AuthSuccessManual extends AuthState {//la reussite de log-in
  final Map<String, dynamic> userData;
  AuthSuccessManual(this.userData);
}
class ProfileLoaded extends AuthState {
  final Map<String, dynamic> user;
  ProfileLoaded(this.user);
  @override
  List<Object?> get props => [user];
}

class ProfileError extends AuthState {
  final String message;
  ProfileError(this.message);
  @override
  List<Object?> get props => [message];
}
class HomeDataLoaded extends AuthState {
  final Map<String, dynamic> data;
  HomeDataLoaded(this.data);

  @override
  List<Object?> get props => [data];
}
class ProfileUpdatedSuccess extends AuthState {}
class SetupLoading extends AuthState {}
class SetupSuccess extends AuthState {}
// import 'package:equatable/equatable.dart';
//
// abstract class AuthState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }
//
// class AuthInitial extends AuthState {}
//
// class AuthLoading extends AuthState {}
//
// class AuthAuthenticated extends AuthState {
//   final Map<String, dynamic> userData;
//   AuthAuthenticated(this.userData);
//
//   @override
//   List<Object?> get props => [userData];
// }
//
// class AuthError extends AuthState {
//   final String message;
//   AuthError(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class EmailSentSuccess extends AuthState {}
//
// class CodeVerifiedSuccess extends AuthState {}
//
// class ProfileLoaded extends AuthState {
//   final Map<String, dynamic> user;
//   ProfileLoaded(this.user);
//
//   @override
//   List<Object?> get props => [user];
// }
//
// class ProfileError extends AuthState {
//   final String message;
//   ProfileError(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
