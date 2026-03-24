// import 'dart:convert';
// import 'package:bloc/bloc.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'authstate.dart';
//
// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());
//
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   Future<void> signInWithGoogle() async {
//     try {
//       emit(AuthLoading());
//
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//
//       if (googleUser == null) {
//         emit(AuthError("User cancelled"));
//         return;
//       }
//
//       final googleAuth = await googleUser.authentication;
//       final idToken = googleAuth.idToken;
//
//       final response = await http.post(
//         Uri.parse("https://yourbackend.com/google-login"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"idToken": idToken}),
//       );
//
//       if (response.statusCode == 200) {
//         emit(AuthSuccess(googleUser));
//       } else {
//         emit(AuthError("Server error"));
//       }
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }
//
//   Future<void> signInWithFacebook() async {
//     try {
//       emit(AuthLoading());
//
//       final LoginResult result = await FacebookAuth.instance.login();
//
//       if (result.status != LoginStatus.success) {
//         emit(AuthError("Facebook login cancelled"));
//         return;
//       }
//
//       final accessToken = result.accessToken!.token;
//
//       final response = await http.post(
//         Uri.parse("https://yourbackend.com/facebook-login"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"accessToken": accessToken}),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         emit(AuthAuthenticated(data));
//       } else {
//         emit(AuthError("Server error"));
//       }
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }
//
//   Future<void> sendEmail(String email) async {
//     try {
//       emit(AuthLoading());
//
//       final response = await http.post(
//         Uri.parse("https://yourbackend.com/api/send-email"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"email": email}),
//       );
//
//       if (response.statusCode == 200) {
//         emit(EmailSentSuccess());
//       } else {
//         emit(AuthError("Erreur du serveur : ${response.statusCode}"));
//       }
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }
//
//   Future<void> verifyCode(String email, String code) async {
//     try {
//       emit(AuthLoading());
//       final response = await http.post(
//         Uri.parse("https://yourbackend.com/api/verify-code"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"email": email, "code": code}),
//       );
//
//       if (response.statusCode == 200) {
//         emit(CodeVerifiedSuccess());
//       } else {
//         emit(AuthError("Code incorrect"));
//       }
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }
//
//   Future<void> registerUser(String email, String password) async {
//     try {
//       emit(AuthLoading());
//
//       final response = await http.post(
//         Uri.parse("https://yourbackend.com/api/register"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "email": email,
//           "password": password,
//         }),
//       );
//
//       // if (response.statusCode == 200 || response.statusCode == 201) {
//       //   final userData = jsonDecode(response.body);
//       //   emit(AuthSuccessManual(userData));
//       // } else {
//       //   emit(AuthError("Erreur lors de l'inscription : ${response.statusCode}"));
//       // }
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }
//   Future<void> fetchProfile(String token) async {
//     try {
//       emit(AuthLoading());
//
//       final response = await http.get(
//         Uri.parse("https://yourbackend.com/api/profile"),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token",
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         emit(ProfileLoaded(data));
//       } else {
//         emit(ProfileError("Failed to load profile"));
//       }
//     } catch (e) {
//       emit(ProfileError(e.toString()));
//     }
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'authstate.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final String _baseUrl = "https://yourbackend.com";
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // --- LOGIN GOOGLE ---
  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthError("User cancelled"));
        return;
      }

      final googleAuth = await googleUser.authentication;
      final response = await http.post(
        Uri.parse("https://yourbackend.com/google-login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"idToken": googleAuth.idToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(AuthAuthenticated(data)); // On utilise l'état authentifié avec les data du backend
      } else {
        emit(AuthError("Server error during Google login"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // --- LOGIN FACEBOOK ---
  Future<void> signInWithFacebook() async {
    try {
      emit(AuthLoading());
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        emit(AuthError("Facebook login cancelled"));
        return;
      }

      final response = await http.post(
        Uri.parse("https://yourbackend.com/facebook-login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"accessToken": result.accessToken!.token}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(AuthAuthenticated(data));
      } else {
        emit(AuthError("Server error during Facebook login"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // --- LOGIN CLASSIQUE (Email/Password) ---
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final response = await http.post(
        Uri.parse("https://yourbackend.com/api/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(AuthAuthenticated(data));
      } else {
        emit(AuthError("Invalid email or password"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // --- INSCRIPTION ---
  Future<void> registerUser(String email, String password) async {
    try {
      emit(AuthLoading());
      final response = await http.post(
        Uri.parse("https://yourbackend.com/api/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userData = jsonDecode(response.body);
        // emit(AuthSuccessManual(userData));
        emit(AuthAuthenticated(userData));
      } else {
        emit(AuthError("Registration failed: ${response.statusCode}"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // --- PROFIL ---
  Future<void> fetchProfile(String token) async {
    try {
      emit(AuthLoading());
      final response = await http.get(
        Uri.parse("https://yourbackend.com/api/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(ProfileLoaded(data));
      } else {
        emit(ProfileError("Failed to load profile"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // Future<void> fetchProfile(String token) async {
  //   emit(ProfileLoaded({
  //     "name": "Captain Test",
  //     "email": "test@mail.com",
  //     "boatName": "Sea Explorer",
  //     "registration": "MAR-9999",
  //     "homePort": "Oran",
  //     "licenseExpiry": "2026",
  //   }));
  // }
  Future<void> fetchHomeData(String token) async {
    try {
      emit(AuthLoading());
      // Simulation d'un appel API
      await Future.delayed(const Duration(seconds: 1));
      final response = await http.get(
        Uri.parse("https://yourbackend.com/api/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(ProfileLoaded(data));
      } else {
        emit(AuthError("Failed to load Home page"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  // --- UPDATE PROFIL ---
  Future<void> updateProfile({
    required String token,
    required String name,
    required String phone,
    required String homePort,
    required String boatName,
  }) async {
    try {
      emit(AuthLoading());
      final response = await http.put(
        Uri.parse("https://backend.com"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "name": name,
          "phone": phone,
          "homePort": homePort,
          "boatName": boatName,
        }),
      );

      if (response.statusCode == 200) {
        emit(ProfileUpdatedSuccess());
      } else {
        emit(ProfileError("Update failed"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // --- COMPLETE SETUP (MULTIPART) ---
  Future<void> submitSetup({
    required String token,
    required String fullName,
    required String nationalId,
    required String phone,
    required String email,
    required String boatName,
    required String registrationNumber,
    required String vesselType,
    required String homePort,
    required String licenseNumber,
    required String expiryDate,
    File? fishingLicense,
    File? boatRegistration,
  }) async {
    try {
      emit(SetupLoading());

      var request = http.MultipartRequest('POST', Uri.parse("$_baseUrl/api/complete-setup"));//un type de http envoier a la fois text et fichier
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data",//la forme de donner ou backend se accepter
      });

      // Champs textes
      request.fields['fullName'] = fullName;
      request.fields['nationalId'] = nationalId;
      request.fields['phone'] = phone;
      request.fields['email'] = email;
      request.fields['boatName'] = boatName;
      request.fields['registrationNumber'] = registrationNumber;
      request.fields['vesselType'] = vesselType;
      request.fields['homePort'] = homePort;
      request.fields['licenseNumber'] = licenseNumber;
      request.fields['expiryDate'] = expiryDate;

      // Ajout des fichiers
      if (fishingLicense != null) {
        request.files.add(await http.MultipartFile.fromPath('fishingLicense', fishingLicense.path));
      }
      if (boatRegistration != null) {
        request.files.add(await http.MultipartFile.fromPath('boatRegistration', boatRegistration.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SetupSuccess());
      } else {
        emit(AuthError("Setup failed: ${response.body}"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
//Fill information page for vitirinaire
  Future<void> submitSetupVit({
    required String token,
    required String fullNameVit,
    required String nationalIdVit,
    required String phoneVit,
    required String emailVit,
    required String boatNameVit,
    required String registrationNumberVit,
    required String homePortVit,
    required String licenseNumberVit,
    required String expiryDateVit,
    File? fishingLicenseVit,
    File? boatRegistrationVit,
  }) async {
    try {
      emit(SetupLoading());

      var request = http.MultipartRequest('POST', Uri.parse("$_baseUrl/api/complete-setup"));
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data",
      });

      request.fields['fullNameVit'] = fullNameVit;
      request.fields['nationalIdVit'] = nationalIdVit;
      request.fields['phoneVit'] = phoneVit;
      request.fields['emailVit'] = emailVit;
      request.fields['boatNameVit'] = boatNameVit;
      request.fields['registrationNumberVit'] = registrationNumberVit;
      request.fields['homePortVit'] = homePortVit;
      request.fields['licenseNumberVit'] = licenseNumberVit;
      request.fields['expiryDateVit'] = expiryDateVit;

      if (fishingLicenseVit != null) {
        request.files.add(await http.MultipartFile.fromPath('fishingLicense', fishingLicenseVit.path));
      }
      if (boatRegistrationVit != null) {
        request.files.add(await http.MultipartFile.fromPath('boatRegistration', boatRegistrationVit.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SetupSuccess());
      } else {
        emit(AuthError("Setup failed: ${response.body}"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // --- LOGOUT ---
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError("Logout failed: ${e.toString()}"));
    }
  }

  // --- EMAIL & CODE ---
  Future<void> sendEmail(String email) async {
    try {
      emit(AuthLoading());
      final response = await http.post(
        Uri.parse("https://yourbackend.com/api/send-email"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );
      if (response.statusCode == 200) {
        emit(EmailSentSuccess());
      } else {
        emit(AuthError("Server error: ${response.statusCode}"));
      }
    } catch (e) { emit(AuthError(e.toString())); }
  }

  Future<void> verifyCode(String email, String code) async {
    try {
      emit(AuthLoading());
      final response = await http.post(
        Uri.parse("https://yourbackend.com/api/verify-code"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "code": code}),
      );
      if (response.statusCode == 200) {
        emit(CodeVerifiedSuccess());
      } else {
        emit(AuthError("Invalid code"));
      }
    } catch (e) { emit(AuthError(e.toString())); }
  }
}