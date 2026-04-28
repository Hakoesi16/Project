import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final GoogleSignInAccount user;
  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthAuthenticated extends AuthState {
  final Map<String, dynamic> user;
  AuthAuthenticated(this.user);
}

class GooglePasswordRequired extends AuthState {
  final String email;
  GooglePasswordRequired(this.email);
}

class EmailSentSuccess extends AuthState {}
class CodeVerifiedSuccess extends AuthState {}
class PasswordSentSuccess extends AuthState {}
class SetupLoading extends AuthState {}
class SetupSuccess extends AuthState {}
class ProfileLoaded extends AuthState {
  final Map<String, dynamic> user;
  ProfileLoaded(this.user);
}
class ProfileUpdatedSuccess extends AuthState {}
class ProfileError extends AuthState {
  final String message;
  ProfileError(this.message);
}
class InspectionDataLoaded extends AuthState { // Nouvel état pour Vet Inspection
  final Map<String, dynamic> data;
  InspectionDataLoaded(this.data);
  @override
  List<Object?> get props => [data];
}
class HomeDataLoaded extends AuthState {
  final Map<String, dynamic> data;
  HomeDataLoaded(this.data);
  @override
  List<Object?> get props => [data];
}
class PasswordUpdatedSuccess extends AuthState {}
// Ajouter cet état → indique que le rôle a été sauvegardé avec succès
class RoleSelectedSuccess extends AuthState {
  final String role;
  RoleSelectedSuccess(this.role);
}
class VetCreatedSuccess extends AuthState {}
class AdminLoaded extends AuthState {
  final Map<String, dynamic> user;
  AdminLoaded(this.user);
  @override
  List<Object?> get props => [user];
}
class ResetPasswordEmailSent extends AuthState {}