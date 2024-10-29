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
  bool hidden = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void togglePassword() {
    hidden = !hidden;
    emit(TogglePasswordState());
  }

  ///------login function----->

  Future<void> login() async {
    emit(AuthLoadingState());
    await DioHelper.post(endPoint: EndPoints.login, body: {
      'email': emailController.text,
      'password': passwordController.text,
    }).then((value) async {
      // to save the user token in flutterSecureStorage to skip the login screen  ⤵
       const storage = FlutterSecureStorage() ;
       await storage.write(key: SharedKeys.token, value: value.data["data"]["token"]) ;
       debugPrint(value.data.toString());
      // debugPrint(value.data["data"]["token"]);
      // print("successful login ya 7oda ");
      emit(AuthSuccessState(value.data["data"]["name"] ));
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


  Future<void> logOut() async {
    emit(AuthLoadingState());
    await DioHelper.post(endPoint: EndPoints.logout ,
        withToken: true,
    ).then((value ) async {
      const storage = FlutterSecureStorage() ;
      debugPrint(value.data.toString());
    await storage.deleteAll();
    emit(AuthSuccessState(value.data["message"]));
    }).catchError((error){
      if(error is DioException){
        debugPrint(error.response?.statusMessage);
        emit(AuthFailedState(error.response?.statusMessage?? "something went wrong in login"));
        return ;
      }
      emit(AuthFailedState(" unknown error"));
    });
  }
}
