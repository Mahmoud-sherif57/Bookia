abstract class AuthState {}

class InitialAuthState extends AuthState {}

////////////////////////////////////
class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final String msg;
  AuthSuccessState(this.msg);
}

class AuthFailedState extends AuthState {
  final String error;
  AuthFailedState(this.error);
}

////////////////////////////////////
class SocialAuthLoadingState extends AuthState {}

class SocialAuthSuccessState extends AuthState {
  final String? msg;
  SocialAuthSuccessState({this.msg});
}

class SocialAuthFailedState extends AuthState {
  final String? error;
  SocialAuthFailedState({this.error});
}

////////////////////////////////////
class ResendOtpLoadingState extends AuthState {}

class ResendOtpSuccessState extends AuthState {
  final String msg;
  ResendOtpSuccessState(this.msg);
}

class ResendOtpFailedState extends AuthState {
  final String error;
  ResendOtpFailedState(this.error);
}

///////////////////////////////////////////
class TogglePasswordState extends AuthState {}

////////////////////////////////////////////
class UpdateProfileLoadingState extends AuthState {}

class UpdateProfileSuccessState extends AuthState {
  final String msg;
  UpdateProfileSuccessState(this.msg);
}

class UpdateProfileFailedState extends AuthState {
  final String error;
  UpdateProfileFailedState(this.error);
}

/////////////////////////////////////////////////////
class UpdatePasswordLoadingState extends AuthState {}

class UpdatePasswordSuccessState extends AuthState {
  final String msg;
  UpdatePasswordSuccessState(this.msg);
}

class UpdatePasswordFailedState extends AuthState {
  final String error;
  UpdatePasswordFailedState(this.error);
}
/////////////////////////////////////////////////////

class GetUserProfileLoading extends AuthState {}

class GetUserProfileSuccess extends AuthState {}

class GetUserProfileFailed extends AuthState {}

/////////////////////////////////////////
class PickImageStateSuccess extends AuthState {}

class PickImageStateFailed extends AuthState {
  final String error;
  PickImageStateFailed(this.error);
}
