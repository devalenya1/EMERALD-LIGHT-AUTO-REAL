import 'dart:convert';

import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/common_response.dart';
import 'package:active_ecommerce_flutter/repositories/api-request.dart';
import 'package:active_ecommerce_flutter/data_model/confirm_code_response.dart';
import 'package:active_ecommerce_flutter/data_model/login_response.dart';
import 'package:active_ecommerce_flutter/data_model/logout_response.dart';
import 'package:active_ecommerce_flutter/data_model/password_confirm_response.dart';
import 'package:active_ecommerce_flutter/data_model/password_forget_response.dart';
import 'package:active_ecommerce_flutter/data_model/resend_code_response.dart';
import 'package:active_ecommerce_flutter/data_model/signup_response.dart';
import 'package:active_ecommerce_flutter/data_model/user_by_token.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<LoginResponse> getLoginResponse(String? email, String password, String loginBy) async {
    // var post_body = jsonEncode({
    //   "email": "${email}",
    //   "password": "$password",
    //   // "identity_matrix": AppConfig.purchase_code,
    //   "login_by":loginBy
    // });
 
    String url = ("${AppConfig.RAW_BASE_URL}/my/login?email=${email}&password=$password&login_by=$loginBy");
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
        },
        // body: post_body
        );

    return loginResponseFromJson(response.body);
  }

  Future<LoginResponse> getSocialLoginResponse(
    String social_provider,
    String? name,
    String? email,
    String? provider, {
    access_token = "",
    secret_token = "",
  }) async {
    email = email == ("null") ? "" : email;

    // var post_body = jsonEncode({
    //   "name": name,
    //   "email": email,
    //   "provider": "$provider",
    //   "social_provider": "$social_provider",
    //   "access_token": "$access_token",
    //   "secret_token": "$secret_token"
    // });

    // print(post_body);
    String url = ("${AppConfig.RAW_BASE_URL}/my/social-login?name=${name}&email=${email}&provider=$provider&social_provider=$social_provider&access_token=$access_token&secret_token=$secret_token");
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
        },
        // body: post_body
        );
    
    return loginResponseFromJson(response.body);
  }

  Future<LogoutResponse> getLogoutResponse() async {
    String url = ("${AppConfig.RAW_BASE_URL}/my/logout");
    final response = await ApiRequest.get(
      url: url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$!,
      },
    );

    // print(response.body);

    return logoutResponseFromJson(response.body);
  }

  Future<CommonResponse> getAccountDeleteResponse() async {
    String url = ("${AppConfig.RAW_BASE_URL}/my/account-deletion");

    // print(url.toString());

    print("Bearer ${access_token.$}");
    final response = await ApiRequest.get(
      url: url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$!,
      },
    );
    // print(response.body);
    return commonResponseFromJson(response.body);
  }

  Future<LoginResponse> getSignupResponse(
    String name,
    String? email_or_phone,
    String password,
    String passowrd_confirmation,
    String register_by,
    String capchaKey,
  ) async {
    // var post_body = jsonEncode({
    //   "name": "$name",
    //   "email_or_phone": "${email_or_phone}",
    //   "password": "$password",
    //   "password_confirmation": "${passowrd_confirmation}",
    //   "register_by": "$register_by",
    //   "g-recaptcha-response": "$capchaKey",
    // });

    String url = ("${AppConfig.RAW_BASE_URL}/my/signup?name=$name&email_or_phone=${email_or_phone}&password=$password&password_confirmation=${passowrd_confirmation}&register_by=$register_by&g-recaptcha-response=$capchaKey");
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
        },
        // body: post_body
        );

    return loginResponseFromJson(response.body);
  }

  Future<ResendCodeResponse> getResendCodeResponse() async {
    String url = ("${AppConfig.RAW_BASE_URL}/my/resend_code");
    final response = await ApiRequest.get(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
          "Authorization": "Bearer ${access_token.$}",
        },);
    return resendCodeResponseFromJson(response.body);
  }

  Future<ConfirmCodeResponse> getConfirmCodeResponse(String verification_code) async {
    // var post_body = jsonEncode({ "verification_code": "$verification_code"});

    String url = ("${AppConfig.RAW_BASE_URL}/my/confirm_code?verification_code=$verification_code");
    // print(url);
    // print(post_body);
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
          "Authorization": "Bearer ${access_token.$}",
        },
        // body: post_body
        );

    return confirmCodeResponseFromJson(response.body);
  }

  Future<PasswordForgetResponse> getPasswordForgetResponse(
      String? email_or_phone, String send_code_by) async {
    // var post_body = jsonEncode(
    //     {"email_or_phone": "$email_or_phone", "send_code_by": "$send_code_by"});

    String url = ("${AppConfig.RAW_BASE_URL}/my/password/forget_request?email_or_phone=${email_or_phone}&send_code_by=$send_code_by");


    final response = await ApiRequest.post(url:url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
        },
        // body: post_body
        );

    return passwordForgetResponseFromJson(response.body);
  }

  Future<PasswordConfirmResponse> getPasswordConfirmResponse(
      String verification_code, String password) async {
    // var post_body = jsonEncode(
    //     {"verification_code": "$verification_code", "password": "$password"});

    String url = ("${AppConfig.RAW_BASE_URL}/my/password/confirm_reset?verification_code=$verification_code&password=$password");
    final response = await ApiRequest.post(url:url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
        },
        // body: post_body
        );

    return passwordConfirmResponseFromJson(response.body);
  }

  Future<ResendCodeResponse> getPasswordResendCodeResponse(
      String? email_or_code, String verify_by) async {
    // var post_body = jsonEncode(
    //     {"email_or_code": "$email_or_code", "verify_by": "$verify_by"});

    String url = ("${AppConfig.RAW_BASE_URL}/my/password/resend_code?email_or_code=${email_or_code}&verify_by=$verify_by");
    final response = await ApiRequest.post(url:url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
        },
        // body: post_body
        );

    return resendCodeResponseFromJson(response.body);
  }

  Future<LoginResponse> getUserByTokenResponse() async {
    // var post_body = jsonEncode({"access_token": "${access_token.$}"});

    String url = ("${AppConfig.RAW_BASE_URL}/my/info?access_token=${access_token.$}");
    if (access_token.$!.isNotEmpty) {
      final response = await ApiRequest.post(url:url,
          headers: {
            "Content-Type": "application/json",
            "App-Language": app_language.$!,
          },
          body: post_body);

      return loginResponseFromJson(response.body);
    }
    return LoginResponse();
  }
}
