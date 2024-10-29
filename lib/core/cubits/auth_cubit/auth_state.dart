abstract class AuthState {}

class InitialAuthState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final String msg;
  AuthSuccessState(this.msg);
}

class AuthFailedState extends AuthState {
  final String error;
  AuthFailedState(this.error);
}


class ResendOtpLoadingState extends AuthState {}
class ResendOtpSuccessState extends AuthState {
  final String msg;
  ResendOtpSuccessState(this.msg);
}
class ResendOtpFailedState extends AuthState {
  final String error;
  ResendOtpFailedState(this.error);
}

class TogglePasswordState extends AuthState {}
