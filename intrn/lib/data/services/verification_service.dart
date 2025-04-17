import 'package:flutter/services.dart';

class VerificationService {

  Future<void> sendVerificationCode(String code) async {

    await Future.delayed(const Duration(seconds: 2));

    if (code != "123456") {
      throw Exception("Invalid verification code");
    }

  }

  Future<void> resendCode() async {
    // ทำงานส่งรหัสใหม่ เช่น call API Firebase Auth หรือ server backend
    await Future.delayed(const Duration(seconds: 1));
  }
}