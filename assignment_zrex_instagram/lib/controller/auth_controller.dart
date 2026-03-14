import 'dart:convert';

import 'package:assignment_zrex_instagram/global_variable.dart';
import 'package:assignment_zrex_instagram/model/user.dart';
import 'package:assignment_zrex_instagram/provider/user_provider.dart';
import 'package:assignment_zrex_instagram/services/manage_http_response.dart';
import 'package:assignment_zrex_instagram/view/screens/authentication_screens/login_screen.dart';
import 'package:assignment_zrex_instagram/view/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  Future<void> signUpUsers({
    required BuildContext context,
    required fullName,
    required username,
    required email,
    required password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        username: username,
        email: email,
        password: password,
        bio: '',
        profilePicture: '',
        token: '',
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user
            .toJson(), //Converts the user object to json body for request body
        headers: <String, String>{
          //Set the header for the request
          'Content-Type':
              'application/json; charset=UTF-8', //specify the context type as json
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
          showSnackBar(context, "Account created successfully");
        },
      );
    } catch (e) {
      print('Signup error: $e');
    }
  }

  //Sign-in User function

  Future<void> signInUsers({
    required BuildContext context,
    required String email,
    required String password,
    required WidgetRef ref,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({
          'email': email, //Include the email in the request body
          'password': password, //Include the password in the request body
        }),
        headers: <String, String>{
          //This will set the headers
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      //handle the response using httpResponse
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          print("API Response: ${response.body}");
          //Access the shared prefrence for token and user data storage
          SharedPreferences preferences = await SharedPreferences.getInstance();
          //Extract the authToken from the response body
          String? token = jsonDecode(response.body)['token'];
          if (token == null) {
            showSnackBar(context, "Login failed: No token received from server");
            return;
          }

          //Store the Authentication token securely in shared preffrence
          await preferences.setString('auth_token', token);

          //Encode the user data recive from the backend as json
          final userJson = jsonEncode(jsonDecode(response.body));

          //Update the application state with the user data with riverpod
          ref.read(userProvider.notifier).setUser(response.body);

          //Store the data in sharedPrefference for future use
          await preferences.setString('user', userJson);

          if (ref.read(userProvider)!.token.isNotEmpty) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            );
            showSnackBar(context, "Account Login successfully");
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }
}
