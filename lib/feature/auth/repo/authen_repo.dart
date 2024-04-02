class AuthenRepository {
  String? _username;
  String? _role;
  String? get role => _role;
  String? get username => _username;

  AuthenRepository();
  AuthenRepository.unknown():_role = null, _username = null;

  void signInWithPassword({
    required String email,
    required String password,
    required String role
  }){
    _role = role;
  }

  void switchAccount({
    required String role
  }){
    _role = role;
  }

  void logOut(){
    
  }
}