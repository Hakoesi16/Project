import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'authstate.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  
  final String _baseUrl = "https://cushionless-buxomly-cherry.ngrok-free.dev/api";
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: "936821595024-uek9ov9mlscdqvbg483dughq9b5u1ksi.apps.googleusercontent.com",
  );

  // Sauvegarde token ET role ensemble
  Future<void> _saveTokenAndRole(String token, String role) async {
    await storage.write(key: "token", value: token);
    await storage.write(key: "role", value: role);
  }

  // Récupère le token
  Future<String?> _getToken() async {
    return await storage.read(key: "token");
  }

  // Récupère le role
  Future<String?> getRole() async {
    return await storage.read(key: "role");
  }

  // Supprime token + role (pour logout)
  Future<void> _clearSession() async {
    await storage.delete(key: "token");
    await storage.delete(key: "role");
  }
  // --- LOGIN GOOGLE+API ---
  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();//pour ouvrir boit de google account

      if (googleUser == null) {
        emit(AuthError("User cancelled"));
        return;
      }

      final googleAuth = await googleUser.authentication; //pour access aux token
      final String? idToken = googleAuth.idToken;
      final String? serverAuthCode = googleUser.serverAuthCode;
      final String email = googleUser.email;

      // Vérification si le token est bien présent
      if (idToken == null) {
        emit(AuthError("Failed to get ID Token from Google"));
        return;
      }

      final response = await http.post(
        Uri.parse("$_baseUrl/auth/google-login-fishmen"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode({
          "idToken": idToken,
          "clientId": "936821595024-uek9ov9mlscdqvbg483dughq9b5u1ksi.apps.googleusercontent.com",
          "serverAuthCode": serverAuthCode,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Sauvegarde token + role si le serveur les renvoie
        if (data['token'] != null && data['role'] != null) {
          await _saveTokenAndRole(data['token'], data['role']);
        }
        // Succès : on envoie l'email pour la suite (Fivepage)
        emit(GooglePasswordRequired(email));
      }else {
        emit(AuthError("Server error: ${response.body}"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // --- LOGIN FACEBOOK+API ---
  Future<void> signInWithFacebook() async {
    try {
      emit(AuthLoading());
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        emit(AuthError("Facebook login cancelled"));
        return;
      }

      final response = await http.post(
        Uri.parse("$_baseUrl/auth/facebook-login-fishmen"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode({"accessToken": result.accessToken!.token}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // ✅ Sauvegarde token + role
        await _saveTokenAndRole(data['token'], data['role']);
        emit(AuthAuthenticated(data));
      } else {
        emit(AuthError("Server error during Facebook login"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // --- LOGIN CLASSIQUE+API ---
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final response = await http.post(
        Uri.parse("$_baseUrl/auth/login-fishmen"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _saveTokenAndRole(data['token'], data['role']);
        emit(AuthAuthenticated(data));
      } else {
        emit(AuthError("Invalid email or password"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  // --- INSCRIPTION+API ---
  Future<void> registerUser(String email, String password) async {
    try {
      emit(AuthLoading());
      final response = await http.post(
        Uri.parse("$_baseUrl/auth/register-fishmen"),
        headers: {
          "Content-Type": "application/json",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userData = jsonDecode(response.body);
        await _saveTokenAndRole(userData['token'], userData['role']);
        emit(AuthAuthenticated(userData));
      } else {
        emit(AuthError("Registration failed: ${response.statusCode}"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // --- PROFIL ---

  // Future<void> fetchProfile() async {
  //   emit(ProfileLoaded({
  //     "name": "Captain Ahmed",
  //     "email": "ahmed@mail.com",
  //     "boatName": "Sea Explorer",
  //     "registration": "MAR-9999",
  //     "homePort": "Oran",
  //     "licenseExpiry": "2026",
  //   }));
  // }


  // --- PROFIL FISHERMAN+API ---
  Future<void> fetchProfile() async {
    try {
      emit(AuthLoading());
      String? token = await _getToken();
      if (token == null) {
        emit(AuthError("No token found"));
        return;
      }
      final response = await http.get(
        Uri.parse("$_baseUrl/auth/get-profile-fishmen"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
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



  //Edit profil FISHERMAN+API
  Future<void> updateProfile({
    required String name,
    required String phone,
    required String homePort,
    required String boatName,
    required String capacity,
    File? profileImage
  }) async {
    try {
      emit(AuthLoading());
      String? token = await _getToken();
      if (token == null) {
        emit(AuthError("No token found"));
        return;
      }

      final response = await http.put(
        Uri.parse("$_baseUrl/auth/get-Edit-profile-fishmen"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode({
          "fullName": name,
          "phone": phone,
          "homePort": homePort,
          "boatName": boatName,
          "capacity": capacity,
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
  // --- COMPLETE SETUP+API ---
  Future<void> submitSetup({
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
    File? Idcard,
  }) async {
    try {
      emit(SetupLoading());
      String? token = await _getToken();
      if (token == null) {
        emit(AuthError("No token found"));
        return;
      }
      var request = http.MultipartRequest('POST', Uri.parse("$_baseUrl/auth/complete-setup-fishmen"));
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true",
      });

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

      if (fishingLicense != null) {
        request.files.add(await http.MultipartFile.fromPath('fishingLicense', fishingLicense.path));
      }
      if (boatRegistration != null) {
        request.files.add(await http.MultipartFile.fromPath('boatRegistration', boatRegistration.path));
      }
      if (Idcard != null) {
        request.files.add(await http.MultipartFile.fromPath('Id-Card', Idcard.path));
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

  // --- LOGOUT+api ---
  Future<void> logout() async {
    try {
      String? token = await _getToken();
      await http.post(
        Uri.parse("$_baseUrl/auth/logout-fishmen"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
      );
      await _googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
      await _clearSession();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError("Logout failed: ${e.toString()}"));
    }
  }

  // --- VET PROFILE ---
  Future<void> fetchvitProfile() async {
    emit(ProfileLoaded({
      "name": "Captain hako",
      "email": "hako@mail.com",
      "boatName": "Sea Explorer",
      "registration": "MAR-9999",
      "homePort": "Oran",
      "licenseExpiry": "2026",
    }));
  }
  // Future<void> fetchvitProfile() async {
  //   try {
  //     emit(AuthLoading());
  //     String? token = await _getToken();
  //     if (token == null) {
  //       emit(AuthError("No token found"));
  //       return;
  //     }
  //     final response = await http.get(
  //       Uri.parse("$_baseUrl/auth/profile-vit"),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer $token",
  //         "ngrok-skip-browser-warning": "true",
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       emit(ProfileLoaded(data));
  //     } else {
  //       emit(ProfileError("Failed to load vet profile: ${response.statusCode}"));
  //     }
  //   } catch (e) {
  //     emit(ProfileError(e.toString()));
  //   }
  // }

  // --- UPDATE VET PROFILE ---

  //edite profile de vitirinaire
  Future<void> updateProfilevit({
    required String name,
    required String phone,
    required String homePort,
    required String boatName,
  }) async {
    try {
      emit(AuthLoading());
      String? token = await _getToken();
      if (token == null) {
        emit(AuthError("No token found"));
        return;
      }
      final response = await http.put(
        Uri.parse("$_baseUrl/api/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "Vname": name,
          "Vphone": phone,
          "VhomePort": homePort,
          "VboatName": boatName,
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
  // --- EMAIL & CODE +API---
  Future<void> sendEmail(String email) async {
    try {
      emit(AuthLoading());
      final response = await http.post(
        Uri.parse("$_baseUrl/auth/send-email-fishmen"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );
      if (response.statusCode == 200) {
        emit(EmailSentSuccess());
      } else {
        emit(AuthError("Server error: ${response.statusCode}"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  Future<void> sendRejectionReason({
    required String batchId,
    required String reason,
  }) async {
    try {
      emit(AuthLoading());
      String? token = await _getToken();
      if (token == null) {
        emit(AuthError("No token found"));
        return;
      }
    final response = await http.post(
      Uri.parse("$_baseUrl/api/reject-batch"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "batchId": batchId,
        "reason": reason,
      }),
    );

    if (response.statusCode == 200) {
      // Vous pouvez émettre un état de succès ici
      emit(InspectionDataLoaded(jsonDecode(response.body)));
    } else {
      emit(AuthError("Failed to send rejection"));
    }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

// --- VET INSPECTION DATA ---par simulation
  //   Future<void> fetchInspectionDetails(String batchId) async {
//     try {
//       emit(AuthLoading());
//   String? token = await _getToken();
//   if (token == null) {
//   emit(AuthError("No token found"));
//   return;
//   }

//
//       final response = await http.get(
//         Uri.parse("https://yourbackend.com/api/inspection/$batchId"),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token", // 🔐 important
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         emit(InspectionDataLoaded({
//           "status": data["status"],
//           "batchId": data["batchId"],
//           "fisherName": data["fisherName"],
//           "fishType": data["fishType"],
//           "expiryDate": data["expiryDate"],
//           "timeLeft": data["timeLeft"],
//         }));
//       } else {
//         emit(AuthError("Failed to load inspection data"));
//       }
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }
  Future<void> fetchInspectionDetails(String batchId) async {
    try {
      emit(AuthLoading());
      // Simulation d'un appel API avec délai
      await Future.delayed(const Duration(milliseconds: 800));

      emit(InspectionDataLoaded({
        "status": "Approved",
        "batchId": "#FSH-99283",
        "fisherName": "Captain Elias",
        "fishType": "Sardin",
        "expiryDate": "Mar 21, 2026",
        "timeLeft": "01 Day, 23 hours restants",
      }));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  //Fill information of Vitirinaire
  Future<void> submitSetupVit({
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
      String? token = await _getToken();
      if (token == null) {
        emit(AuthError("No token found"));
        return;
      }
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
  // --- HOME DATA FISHERMAN ---
  Future<void> fetchHomeData() async {
    try {
      emit(AuthLoading());
      // String? token = await _getToken();
      // if (token == null) {
      //   emit(AuthError("No token found"));
      //   return;
      // }
      await Future.delayed(const Duration(seconds: 1));
      emit(HomeDataLoaded({
        "userName":        "Capt. Ahmed",
        "earnings":        "12,450.00 DA",
        "earningsTrend":   "8.4%",
        "weight":          "4,250 kg",
        "weightTrend":     "5.2%",
        "pendingBatches":  24,
        "approvedBatches": 85,
        "rejectedBatches": 12,
        "expiredBatches":  7,

        // ✅ Donut — valeurs numériques
        "batch_approved":  72.0,
        "batch_expired":   18.0,
        "batch_pending":    4.0,
        "batch_rejected":   6.0,

        // ✅ Donut — labels String
        "approved_label": "72%",
        "expired_label":  "18%",
        "pending_label":   "4%",
        "rejected_label":  "6%",
        "batch":          "105",   // ← nombre au centre

        // ✅ Fish distribution
        "sardine_pct":    42.5,
        "salmon_pct":     28.1,
        "tuna_pct":       15.4,
        "seabass_pct":     9.2,
        "other_pct":       4.8,
        "sardine_label":  "42.5%",
        "salmon_label":   "28.1%",
        "tuna_label":     "15.4%",
        "seabass_label":   "9.2%",
        "other_label":     "4.8%",
      }));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  // Future<void> fetchHomeData() async {
  //   try {
  //     emit(AuthLoading());
  //     String? token = await _getToken();
  //     if (token == null) {
  //       emit(AuthError("No token found"));
  //       return;
  //     }
  //     // Simulation d'un appel API
  //     await Future.delayed(const Duration(seconds: 1));
  //     final response = await http.get(
  //       Uri.parse("https://yourbackend.com/api/profile"),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer $token",
  //         "ngrok-skip-browser-warning": "true",
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       emit(ProfileLoaded(data));
  //     } else {
  //       emit(AuthError("Failed to load Home page"));
  //     }
  //   } catch (e) {
  //     emit(AuthError(e.toString()));
  //   }
  // }

  //profile de consumer
  Future<void> fetchConsumerProfile() async {
    emit(ProfileLoaded({
      "name": "Captain hako",
      "email": "hako@mail.com",
      "boatName": "Sea Explorer",
      "registration": "MAR-9999",
      "homePort": "Oran",
      "licenseExpiry": "2026",
    }));
  }
  // Future<void> fetchConsumerProfile() async {
  //   try {
  //     emit(AuthLoading());
  //     String? token = await _getToken();
  //     if (token == null) {
  //       emit(AuthError("No token found"));
  //       return;
  //     }
  //
  //     final response = await http.get(
  //       Uri.parse("https://api.example.com/profileConsumer"),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer $token",
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       emit(ProfileLoaded(data));
  //     } else {
  //       emit(ProfileError("Failed to load profile"));
  //     }
  //   } catch (e) {
  //     emit(ProfileError(e.toString()));
  //   }
  // }



  //Fill information of Consumer
  //SUBMIT SETUP CONSUMER
  Future<void> submitSetupCons({
    required String fullNameCons,
    required String nationalIdCons,
    required String phoneCons,
    required String emailCons,
    required String delevryAddress,
    required String nearbyPortCons,
  }) async {
    try {
      emit(SetupLoading());
      String? token = await _getToken();
      if (token == null) {
        emit(AuthError("No token found"));
        return;
      }

      var request = http.MultipartRequest('POST', Uri.parse("$_baseUrl/api/complete-setup"));
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data",
      });

      request.fields['fullNameCons'] = fullNameCons;
      request.fields['nationalIdCons'] = nationalIdCons;
      request.fields['phoneCons'] = phoneCons;
      request.fields['emailCons'] = emailCons;
      request.fields['delevryAddress'] = delevryAddress;
      request.fields['nearbyPort'] = nearbyPortCons;

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
  // --- UPDATE PASSWORD FISHERMAN+API ---
  Future<void> updatePassword({
    required String password, required String currentPassword,
  }) async {
    try {
      emit(AuthLoading());
      String? token = await _getToken();
      if (token == null) {
        emit(AuthError("No token found"));
        return;
      }
      final response = await http.put(
        Uri.parse("$_baseUrl/auth/change-password"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode({
          "currentPassword": currentPassword,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        emit(PasswordUpdatedSuccess());
      } else {
        emit(ProfileError("Update failed"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }


// --- UPDATE PASSWORD VET ---
  Future<void> updatePasswordVit({
    required String passwordVit,
    required String currentpasswordVit,
  }) async {
    try {
      emit(AuthLoading());
      String? token = await _getToken();
      if (token == null) {
        emit(AuthError("No token found"));
        return;
      }

      final response = await http.put(
        Uri.parse("$_baseUrl/auth/update-profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode({
          "currentpasswordVit":currentpasswordVit,
          "passwordVit": passwordVit,
        }),
      );

      if (response.statusCode == 200) {
        emit(PasswordUpdatedSuccess());
      } else {
        emit(ProfileError("Update failed"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
  // --- UPDATE PASSWORD CONSUMER ---
  Future<void> updatePasswordCons({
    required String passwordCons,
    required String currentpasswordCons,
  }) async {
    try {
      emit(AuthLoading());
      String? token = await _getToken();
      if (token == null) {
        emit(AuthError("No token found"));
        return;
      }

      final response = await http.put(
        Uri.parse("$_baseUrl/auth/update-profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode({
          "currentpaaswordCons":currentpasswordCons,
          "passwordCons": passwordCons,
        }),
      );

      if (response.statusCode == 200) {
        emit(PasswordUpdatedSuccess());
      } else {
        emit(ProfileError("Update failed"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
  //edit profile consumer
  Future<void> updateProfileConsumer({
    required String name_cons,
    required String phone_cons,
    required String homePort_cons,
    required String boatName_cons,
  }) async {
    try {
      emit(AuthLoading());
      String? token_cons = await _getToken();
      if (token_cons == null) {
        emit(AuthError("No token found"));
        return;
      }

      final response = await http.put(
        Uri.parse("$_baseUrl/auth/update-profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token_cons",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode({
          "fullName": name_cons,
          "phone": phone_cons,
          "homePort": homePort_cons,
          "boatName": boatName_cons,
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
  // --- SÉLECTION DU RÔLE ---
  Future<void> selectRole(String role) async {
    try {
      emit(AuthLoading());

      String? token = await _getToken();
      if (token == null) {
        emit(AuthError("No token found"));
        return;
      }

      // Envoie le rôle au backend
      final response = await http.post(
        Uri.parse("$_baseUrl/auth/select-role"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true",
        },
        body: jsonEncode({"role": role}),
        // on envoie : {"role": "fishmen"}
        // ou         {"role": "vet"}
        // ou         {"role": "consumer"}
      );

      if (response.statusCode == 200) {
        // Sauvegarde le rôle localement
        await storage.write(key: "role", value: role);
        emit(RoleSelectedSuccess(role)); // → redirige selon le rôle
      } else {
        emit(AuthError("Failed to select role: ${response.body}"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  // --- VÉRIFICATION CODE+API ---
  Future<void> verifyCode(String email, String code) async {
    try {
      emit(AuthLoading());
      final response = await http.post(
          Uri.parse("$_baseUrl/auth/verify-code-fishmen"),
          headers:
          {
            "Content-Type": "application/json",
            "ngrok-skip-browser-warning": "true",
          },
          body: jsonEncode({"email": email, "code": code,}));
      if (response.statusCode == 200) {
        emit(CodeVerifiedSuccess());
      } else {
        emit(AuthError("Server error: ${response.statusCode}"));
      }
    }catch(e){
      emit(AuthError(e.toString()));

    }
    }
    // --- ADMIN AUTHENTICATION ---
  Future<void> submitAdmin({
    required String emailvet,
    required String passwordvet,
    required String homePortvet,
  }) async {
    try {
      emit(SetupLoading());
      String? token = await _getToken();
      if (token == null) {
        emit(AuthError("No token found"));
        return;
      }
      final response = await http.post(
          Uri.parse("$_baseUrl/auth/code_verification"),
          headers:
          {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "ngrok-skip-browser-warning": "true",
          },
          body: jsonEncode({"emailvet": emailvet, "passwordvet": passwordvet, "homePortvet": homePortvet,}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(VetCreatedSuccess());
      } else {
        emit(AuthError("Setup failed: ${response.body}"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  //---FETCH ADMIN---
  Future<void> fetchadmin() async {
  try {
    emit(AuthLoading());
    String? token = await _getToken();
    if (token == null) {
      emit(AuthError("No token found"));
      return;
    }
    // Simulation d'un appel API
    await Future.delayed(const Duration(seconds: 1));
    final response = await http.get(
      Uri.parse("https://yourbackend.com/api/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true",
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      emit(AdminLoaded(data));
    } else {
      emit(AuthError("Failed to load Admin page"));
    }
  } catch (e) {
    emit(AuthError(e.toString()));
  }
}
//---Reset password+API---
  Future<void> resetPassword(String email) async {
    try {
      emit(AuthLoading());

      final response = await http.post(
        Uri.parse("$_baseUrl/auth/reset-password-fishmen"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        emit(ResetPasswordEmailSent());
      } else {
        emit(AuthError("Failed to send reset email"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
