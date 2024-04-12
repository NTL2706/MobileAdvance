import 'dart:convert';

import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/feature/auth/constants/auth_state.dart';
import 'package:final_project_advanced_mobile/feature/auth/repo/authen_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticateProvider extends ChangeNotifier {
  AuthenRepository authenRepository = AuthenRepository();
  late AuthState state;

  AuthenticateProvider() {
    if (authenRepository.role != "") {
      state = AuthState(
          result: AuthResult.success,
          isLoading: false,
          userName: authenRepository.username);
    }
    state = AuthState.unknown();
  }
  Future<void> signInWithPassword(
      {required String email,
      required String password,
      required String role}) async {
    state = state.copiedWithIsLoading(true);
    notifyListeners();
    final response = await authenRepository.signInWithPassword(
        email: email, password: password, role: role);

    if (response['result'] == AuthResult.success) {
      await getUserInf();
    }
    state = AuthState(
        result: response['result'],
        isLoading: false,
        userName: authenRepository.username,
        message: response['message']);
    notifyListeners();
  }

  Future<void> signOut() async {
    authenRepository.logOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "");
    prefs.setString('role', "");
    authenRepository = AuthenRepository.unknown();
  }

  Future<void> signUpWithPassword(
      {required String email,
      required String password,
      required String fullname,
      required int role}) async {
    state = state.copiedWithIsLoading(true);
    notifyListeners();
    final response = await authenRepository.signUpWithPassword(
        email: email, password: password, fullname: fullname, role: role);
    state = AuthState(
        result: response['result'],
        isLoading: false,
        userName: authenRepository.username,
        message: response['message']);
    notifyListeners();
  }

  Future<Map<String, dynamic>> getUserInf() async {
    await authenRepository.getUserInf();

    return {
      "student": authenRepository.student,
      "company": authenRepository.company,
    };
  }

  Future<void> switchProfile({required String role}) async {
    await authenRepository.switchAccount(role: role);
  }

  Future<String> test() async {
    state = state.copiedWithIsLoading(true);

    return "111";
  }

  Future<void> ChangePw({
    required String oldPw,
    required String newPw,
  }) async {
    state = state.copiedWithIsLoading(true);
    notifyListeners();
    final response = await authenRepository.changePassword(
      oldPw: oldPw,
      password: newPw,
    );

    if (response['result'] == AuthResult.success) {
      await getUserInf();
    }
    state = AuthState(
        result: response['result'],
        isLoading: false,
        userName: authenRepository.username,
        message: response['message']);
    notifyListeners();
  }
}
