
import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';

class AuthState{
  final AuthResult? result;
  final bool isLoading;
  final String? userName;
  final String? message;
  const AuthState(
    {
      required this.result,
      required this.isLoading,
      required this.userName,
      this.message
    }
  );

  AuthState.unknown():result = null, isLoading = false, userName = null, message = null;

  AuthState copiedWithIsLoading(bool isLoading) => AuthState(result: result, isLoading: isLoading, userName: userName);
  AuthState copiedWithMessgae(bool isLoading) => AuthState(result: result, isLoading: isLoading, userName: userName,message: message);


  @override
  bool operator== (covariant AuthState other) => identical(this, other) || (result == other.result && isLoading == other.isLoading && userName == other.userName);

  @override
  int get hashCode {
    return Object.hash(result, isLoading, userName);
  }
}