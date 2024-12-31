import 'dart:convert';
import 'dart:io';

import 'package:gomedserv/utils/gomedapi.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth.dart';

import 'loader.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.initial());

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
    state = AuthState.initial(); // Correct usage of state
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    // Check if userData exists in shared preferences
    if (!prefs.containsKey('userData')) {
      print('tryAutoLogin is false');
      return false;
    }
    print("All keys in SharedPreferences: ${prefs.getKeys()}");
    for (String key in prefs.getKeys()) {
      print("Key: $key, Value: ${prefs.get(key)}");
    }

    // Extract user data from shared preferences
    final extractedData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    print("User Data (parsed JSON): $extractedData");
    print(
        "From tryAutoLogin: SharedPreferences contains user data. $extractedData");

    // Correctly parse and assign data fields
    final newUser = Data(
      userId: extractedData['userId'] ?? 0, // Default to 0 if null
      username: extractedData['username'] ?? '', // Default to empty string
      countryname: extractedData['countryname'] ?? '',
      state: extractedData['state'] ?? '',
      city: extractedData['city'] ?? '',
      address: extractedData['address'] ?? '',
      profilePic: extractedData['profile_pic'] ?? '',
      useRole: extractedData['use_role'] ?? '',
      idFront: extractedData['id_front'] ?? '',
      idBack: extractedData['id_back'] ?? '',
      idCard: extractedData['id_card'] ?? '',
      bankaccountno: extractedData['bankaccountno'] ?? '',
      bankname: extractedData['bankname'] ?? '',
      ifsccode: extractedData['ifsccode'] ?? '',
      latitude: extractedData['latitude'] != null
          ? double.tryParse(extractedData['latitude'].toString()) ?? 0.0
          : 0.0,
      longitude: extractedData['longitude'] != null
          ? double.tryParse(extractedData['longitude'].toString()) ?? 0.0
          : 0.0,
      radius: extractedData['radius'] != null
          ? double.tryParse(extractedData['radius'].toString()) ?? 0.0
          : 0.0,
      accessToken: extractedData['access_token'] ?? '',
      accessTokenExpiresAt: extractedData['accessTokenExpiry'] != null
          ? DateTime.tryParse(extractedData['accessTokenExpiry'])
              ?.millisecondsSinceEpoch
          : null,
      refreshToken: extractedData['refresh_token'] ?? '',
      refreshTokenExpiresAt: extractedData['refreshTokenExpiry'] != null
          ? DateTime.tryParse(extractedData['refreshTokenExpiry'])
              ?.millisecondsSinceEpoch
          : null,
    );

    // Update the AuthState with new data
    state = state.copyWith(data: newUser);

    print('Access token: ${state.data.accessToken}');
    print('Refresh token: ${state.data.refreshToken}');

    // Check if the userStatus is valid

    // Debug: Log the access token
    print('Refresh token from tryAutoLogin: ${state.data.refreshToken}');

    // Return true if access token is not empty
    return state.data.accessToken.isNotEmpty;
  }

  Future<int> adminLogin(WidgetRef ref,
      {required String username, required String password}) async {
    // Start loading indicator
    var loader = ref.read(loadingProvider.notifier);
    loader.state = true;
    var body = json.encode({"username": username, "password": password});
    // Define the URL for the login API
    final url = '${GomedApi().baseUrl}${GomedApi().login}';

    // Fetch shared preferences instance to store user data
    final prefs = await SharedPreferences.getInstance();
    int statusCode = 0;
    try {
      // Prepare headers and body

      // Print the Content-Type header before making the API call

      // Make the POST request to the login API with username and password
      var response = await http.post(
        Uri.parse(url),
        body: body,
      );
      statusCode = response.statusCode;

      // Parse the response body
      var responseData = json.decode(response.body);
      print("chck mobile mo $responseData");
      List<String> messages = [];
      if (responseData['messages'] != null &&
          responseData['messages'] is List) {
        // Convert List<dynamic> to List<String>
        messages = List<String>.from(
            responseData['messages'].map((item) => item.toString()));
      } else {
        // Handle cases where messages is missing or not in the expected format
        messages = ["An unexpected error occurred."];
      }

      // Handle different status codes
      switch (response.statusCode) {
        case 401:
          print("mobile no does not exists");
          loader.state = false;
          // Optionally, update state with an error message
          state = state.copyWith(messages: messages);
          break;

        case 201:
          print("Login success - Access and refresh tokens received");
          final authState = AuthState.fromJson(responseData);
          final newAccessToken = authState.data.accessToken;
          final newAccessTokenExpiryDate =
              authState.data.accessTokenExpiresAt != null
                  ? DateTime.fromMillisecondsSinceEpoch(
                      authState.data.accessTokenExpiresAt!)
                  : null;
          final newRefreshToken = authState.data.refreshToken;
          final newRefreshTokenExpiryDate =
              authState.data.refreshTokenExpiresAt != null
                  ? DateTime.fromMillisecondsSinceEpoch(
                      authState.data.refreshTokenExpiresAt!)
                  : null;

          // Update state and save to SharedPreferences
          state = state.copyWith(
            data: authState.data.copyWith(
              accessToken: newAccessToken,
              accessTokenExpiresAt:
                  newAccessTokenExpiryDate?.millisecondsSinceEpoch,
              refreshToken: newRefreshToken,
              refreshTokenExpiresAt:
                  newRefreshTokenExpiryDate?.millisecondsSinceEpoch,
            ),
          );
          final userData = json.encode({
            'username': authState.data.username,
            'access_token': newAccessToken,
            'accessTokenExpiry': newAccessTokenExpiryDate?.toIso8601String(),
            'refresh_token': newRefreshToken,
            'refreshTokenExpiry': newRefreshTokenExpiryDate?.toIso8601String(),
            'userId': authState.data.userId,
            'countryname': authState.data.countryname,
            'state': authState.data.state,
            'city': authState.data.city,
            'address': authState.data.address,
            'profile_pic': authState.data.profilePic,
            'use_role': authState.data.useRole,
            'id_front': authState.data.idFront,
            'id_back': authState.data.idBack,
            'id_card': authState.data.idCard,
            'bankaccountno': authState.data.bankaccountno,
            'bankname': authState.data.bankname,
            'ifsccode': authState.data.ifsccode,
            'latitude': authState.data.latitude,
            'longitude': authState.data.longitude,
            'radius': authState.data.radius,
          });

          await prefs.setString('userData', userData);

          // Append location data to the 'locations' list under the given ID

          loader.state = false;

          break;

        default:
          print("Unhandled status code: ${response.statusCode}");
          loader.state = false;
          // Optionally, update state with an error message
          state = state.copyWith(
            messages: ["An unexpected error occurred. Please try again."],
          );
          break;
      }
    } on FormatException catch (formatException) {
      print('Format Exception: ${formatException.message}');
      print('Invalid response format.');
      state = state.copyWith(
        messages: ["Invalid response from server."],
      );
    } on HttpException catch (httpException) {
      print('HTTP Exception: ${httpException.message}');
      state = state.copyWith(
        messages: ["Network error occurred."],
      );
    } catch (e, stackTrace) {
      print('General Exception: ${e.toString()}');
      print('Stack Trace: $stackTrace');
      state = state.copyWith(
        messages: ["An error occurred. Please try again."],
      );
    } finally {
      loader.state = false;
    }
    return statusCode;
  }
}

// Define the provider for AuthNotifier
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
