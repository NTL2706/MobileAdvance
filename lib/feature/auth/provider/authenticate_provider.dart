import 'package:final_project_advanced_mobile/feature/auth/repo/authen_repo.dart';
import 'package:flutter/cupertino.dart';

class AuthenticateProvider extends ChangeNotifier{
  AuthenRepository authenRepository = AuthenRepository();
  
  void signInWithPassword({
    required String email,
    required String password,
    required String role 
  }){
    authenRepository.signInWithPassword(email: email, password: password, role: role);
    notifyListeners();
  }

  void signOut(){
    authenRepository.logOut();
    authenRepository = AuthenRepository.unknown();
    notifyListeners();
  }
}