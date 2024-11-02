import 'package:bookia_118/data/network/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../data/local/shared_keys.dart';
import '../../../data/network/end_points.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  final storage = const FlutterSecureStorage();
  bool hidden = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();

  ///---------toggle Password Function--------------->
  void togglePassword() {
    hidden = !hidden;
    emit(TogglePasswordState());
  }

  ///---------LogIn Function--------------->

  Future<void> login() async {
    emit(AuthLoadingState());
    await DioHelper.post(endPoint: EndPoints.login, body: {
      'email': emailController.text,
      'password': passwordController.text,
    }).then((value) async {
      // to save the user token in flutterSecureStorage to skip the login screen  ⤵
      await storage.write(key: SharedKeys.token, value: value.data["data"]["token"]);
      debugPrint(value.data.toString());
      // debugPrint(value.data["data"]["token"]);
      // print("successful login ya 7oda ");
      emit(AuthSuccessState(value.data["data"]["name"]));
    }).catchError((error) {
      if (error is DioException) {
        // debugPrint(error.response?.data?["message"]);
        debugPrint(error.response?.data.toString());
        emit(AuthFailedState(error.response?.data?["message"] ?? "something went wrong in login"));
        // emit(AuthFailedState(error.message ?? "something went wrong in login"));
        return;
      }
      emit(AuthFailedState(" unknown error"));
    });
  }

  ///---------LogOut Function--------------->

  Future<void> logOut() async {
    emit(AuthLoadingState());
    await DioHelper.post(
      endPoint: EndPoints.logout,
      withToken: true,
    ).then((value) async {
      const storage = FlutterSecureStorage();
      debugPrint(value.data.toString());
      await storage.deleteAll();
      emit(AuthSuccessState(value.data["message"]));
    }).catchError((error) {
      if (error is DioException) {
        debugPrint(error.response?.toString());
        emit(AuthFailedState(error.response?.data?["message"] ?? "something went wrong in login"));
        return;
      }
      emit(AuthFailedState(" unknown error"));
    });
  }

  ///---------Register Function--------------->

  Future<void> register() async {
    emit(AuthLoadingState());
    await DioHelper.post(endPoint: EndPoints.register, body: {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "confirm_password": confirmPasswordController.text,
    }).then((value) async {
      await storage.write(key: SharedKeys.token, value: value.data["data"]["token"]);
      debugPrint(value.data.toString());
      emit(AuthSuccessState(value.data["data"]["name"]));
    }).catchError((error) {
      if (error is DioException) {
        debugPrint(error.response?.data.toString());
        emit(AuthFailedState(error.response?.data?["message"] ?? "something went wrong in register"));
        return;
      }
      emit(AuthFailedState(" unknown error"));
    });
  }

  ///---------forgot Password Function--------------->
  Future<void> forgotPassword() async {
    emit(AuthLoadingState());
    emit(ResendOtpLoadingState());
    await DioHelper.post(endPoint: EndPoints.forgotPassword, body: {
      "email": emailController.text,
    }).then((value) {
      debugPrint(value.data.toString());
      emit(AuthSuccessState(value.data["message"]));
      emit(ResendOtpSuccessState(value.data["message"]));
    }).catchError((error) {
      if (error is DioException) {
        debugPrint(error.response?.data.toString());
        emit(AuthFailedState(error.response?.data?["message"] ?? "something went wrong in register"));
        emit(ResendOtpFailedState(error.response?.data?["message"] ?? "something went wrong in register"));
        return;
      }
      emit(AuthFailedState(" unknown error"));
      emit(ResendOtpFailedState(error.response?.data?["message"] ?? "something went wrong in register"));
    });
  }

  ///---------Verify Code Function--------------->
  // we used sendOtp function to validate if the user wrote the 4 numbers or not ..
  void sendOtp() {
    String otp = otpController1.text + otpController2.text + otpController3.text + otpController4.text;
    if (otp.length == 4) {
      verifyCode(otp);
    }
  }

  Future<void> verifyCode(String otp) async {
    emit(AuthLoadingState());
    await DioHelper.post(endPoint: EndPoints.verifyCode, body: {
      "email": emailController.text,
      "otp": otp,
    }).then((value) async {
      debugPrint(value.data.toString());
      emit(AuthSuccessState(value.data["message"]));
      await storage.write(key: SharedKeys.token, value: value.data["data"]["token"]);
    }).catchError((error) {
      if (error is DioException) {
        debugPrint(error.response?.data.toString());
        emit(AuthFailedState(error.response?.data?["message"] ?? "something went wrong in register"));
        return;
      }
      emit(AuthFailedState(" unknown error"));
    });
  }

  ///---------reset Password Function--------------->

  Future<void> resetPassword() async {
    emit(AuthLoadingState());
    await DioHelper.post(
      endPoint: EndPoints.updatePassword,
      body: {
        "password": passwordController.text,
        "confirm_password": confirmPasswordController.text,
      },
      withToken: true,
    ).then((value) {
      debugPrint(value.data.toString());
      emit(AuthSuccessState(value.data["message"]));
    }).catchError((error) {
      if (error is DioException) {
        debugPrint(error.response?.statusMessage);
        emit(AuthFailedState(error.response?.statusMessage ?? "something went wrong in login"));
        return;
      }
      emit(AuthFailedState(" unknown error"));
    });
  }

  ///---------update profile Function--------------->

  Future<void> updateProfile() async {
    emit(UpdateProfileLoadingState());
    await DioHelper.post(
      endPoint: EndPoints.updateProfile,
      withToken: true,
      body: {
        "name": nameController.text,
        "email": emailController.text,
        "image": "",
        "address": addressController.text,
      },
    ).then((value) {
      debugPrint(value.data.toString());
      emit(UpdateProfileSuccessState(value.data["message"]));
    }).catchError(( error){
      if(error is DioException){
        debugPrint(error.response?.data?["message"]);
        emit(UpdateProfileFailedState(error.response?.data?["message"]));
      return ;
      }
      debugPrint(error.response?.data?["message"]);
      emit(UpdateProfileFailedState(" unknown error"));

    });
  }

  ///---------update profile Function--------------->

  Future<void> updatePassword() async {
    emit(UpdatePasswordLoadingState());
    await DioHelper.post(
      endPoint: EndPoints.resetPassword,
      withToken: true,
      body: {
        "current_password": passwordController.text,
        "new_password":newPasswordController.text,
        "confirm_password": confirmPasswordController.text,
      },
    ).then((value) {
      debugPrint(value.data.toString());
      emit(UpdatePasswordSuccessState(value.data["message"]));
    }).catchError(( error){
      if(error is DioException){
        debugPrint(error.response?.data?["message"]);
        emit(UpdatePasswordFailedState(error.response?.data?["message"]));
        return ;
      }
      debugPrint(error.response?.data?["message"]);
      emit(UpdatePasswordFailedState(" unknown error"));

    });
  }
}
