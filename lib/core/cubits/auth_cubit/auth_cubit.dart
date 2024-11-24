import 'dart:convert';
import 'dart:io';
import 'package:bookia_118/data/models/user_info_google_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/data/network/dio_helper.dart';
import 'package:bookia_118/data/models/user_info_model.dart';
import 'package:bookia_118/feature/login/presentation/screens/login_screen.dart';
import 'package:bookia_118/feature/wrapper_screen/presentation/screen/wrapper_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/local/shared_keys.dart';
import '../../../data/network/end_points.dart';
import '../../constants/app_strings.dart';
import '../category_cubit/category_cubit.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  final storage = const FlutterSecureStorage();
  bool hidden = true;
  // List<UserInfoModel> userInformationList = [];
  Map<String, dynamic> userInfoMap = {};

  String? userName;
  String? userEmail;
  String? userPhoto;

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

  ///-------------- check if the user is logged in---------->
  // we can call this in multiBlockProvider with cascade operation to run this before entering the splash screen

  Future<void> checkUserToken(BuildContext context) async {
    String? userToken = await storage.read(key: SharedKeys.token);
    if (userToken != null) {
      CategoryCubit.get(context).getAllBooks();
    } else {
      AppFunctions.navigateAndRemove(context, const LoginScreen());
    }
  }

  ///---------LogIn with google function--------------->

  UserInfoGoogleModel? userInfoGoogleModel;
  Future logInWithGoogle(BuildContext context) async {
    try {
      emit(SocialAuthLoadingState());
      // to show the pop up and pick an google account
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // to make authentication on the picked user account
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      // here we take the (accessToken & IdToken) from signInGoogle and send it to firebaseAuth..
      // Once signed in, return the UserCredential

      final credential =
          GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint(
          "${userCredential.user?.displayName}\n ${userCredential.user?.email}\n ${userCredential.user?.photoURL}");

      if (googleUser == null) {
        emit(SocialAuthFailedState());
        return;
      } else {
        emit(SocialAuthSuccessState());

        userInfoGoogleModel = UserInfoGoogleModel(
          displayName: googleUser.displayName ?? "",
          email: googleUser.email,
          photoUrl: googleUser.photoUrl ?? "",
        );
        await saveUserDataInPrefs(userInfoGoogleModel!);
        await storage.write(key: SharedKeys.token, value: googleAuth?.accessToken);

        AppFunctions.navigateAndRemove(context, const WrapperHomeScreen());
      }
    } catch (error, stackTrace) {
      debugPrint("=========Error during Google Sign-In: $error\n$stackTrace");
      emit(SocialAuthFailedState());
      return null; // because i don't want the user to see the technical error
    }
  }

  ///---------save the user <google> data in sharedPreferences--------------->
  Future<void> saveUserDataInPrefs(UserInfoGoogleModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedKeys.displayName, user.displayName ?? "");
    await prefs.setString(SharedKeys.email, user.email ?? "");
    await prefs.setString(SharedKeys.photoUrl, user.photoUrl ?? "");
  }

  ///---------get the user <google> data from sharedPreferences--------------->
  Future<UserInfoGoogleModel?> getUserDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString(SharedKeys.displayName);
    userEmail = prefs.getString(SharedKeys.email);
    userPhoto = prefs.getString(SharedKeys.photoUrl);

    if (userName != null && userEmail != null) {
      return UserInfoGoogleModel(
        displayName: userName ?? "",
        email: userEmail ?? "",
        photoUrl: userPhoto ?? "",
      );
    }
    return null;
  }

  /// --------logOutGoogle function----------->
  Future<void> logOutGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    await storage.delete(key: SharedKeys.token);
  }

  ///---------- log in with facebook------->

  Future<UserCredential> signInWithFacebook(BuildContext context) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    debugPrint("==============================");
    debugPrint(loginResult.message);
    debugPrint(loginResult.accessToken.toString());
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    debugPrint(userCredential.additionalUserInfo?.username);
    debugPrint(userCredential.additionalUserInfo?.authorizationCode);
    debugPrint(userCredential.user?.email);
    debugPrint(userCredential.user?.photoURL);
    debugPrint(userCredential.user?.phoneNumber);
    debugPrint(userCredential.user?.emailVerified.toString());
    return userCredential;
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
      emit(AuthSuccessState(value.data["data"]["name"]));
    }).catchError((error) {
      if (error is DioException) {
        emit(AuthFailedState(error.response?.data?["message"] ?? "something went wrong in login"));
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
      await storage.deleteAll();
      emit(AuthSuccessState(value.data["message"]));
    }).catchError((error) {
      if (error is DioException) {
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
      // debugPrint(value.data.toString());
      emit(AuthSuccessState(value.data["data"]["name"]));
    }).catchError((error) {
      if (error is DioException) {
        // debugPrint(error.response?.data.toString());
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
      // debugPrint(value.data.toString());
      emit(AuthSuccessState(value.data["message"]));
      emit(ResendOtpSuccessState(value.data["message"]));
    }).catchError((error) {
      if (error is DioException) {
        // debugPrint(error.response?.data.toString());
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
      emit(AuthSuccessState(value.data["message"]));
      await storage.write(key: SharedKeys.token, value: value.data["data"]["token"]);
    }).catchError((error) {
      if (error is DioException) {
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
      // debugPrint(value.data.toString());
      emit(AuthSuccessState(value.data["message"]));
    }).catchError((error) {
      if (error is DioException) {
        // debugPrint(error.response?.statusMessage);
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
        "address": addressController.text,
        "image": userImage!
      },
    ).then((value) {
      // debugPrint(value.data.toString());
      // debugPrint(value.data["image"]);
      emit(UpdateProfileSuccessState(value.data["message"]));
    }).catchError((error) {
      if (error is DioException) {
        // debugPrint(error.response?.data?["message"]);
        emit(UpdateProfileFailedState(error.response?.data?["message"] ?? ""));
        return;
      }
      // debugPrint("====== there an error in update user profile ");
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
        "new_password": newPasswordController.text,
        "confirm_password": confirmPasswordController.text,
      },
    ).then((value) {
      // debugPrint(value.data.toString());
      emit(UpdatePasswordSuccessState(value.data["message"]));
    }).catchError((error) {
      if (error is DioException) {
        // debugPrint(error.response?.data?["message"]);
        emit(UpdatePasswordFailedState(error.response?.data?["message"]));
        return;
      }
      // debugPrint(error.response?.data?["message"]);
      emit(UpdatePasswordFailedState(" unknown error"));
    });
  }

  ///--------get profile function------->

  Future<void> getUserProfile() async {
    emit(GetUserProfileLoading());
    await DioHelper.get(
      endPoint: EndPoints.getProfile,
      withToken: true,
    ).then((value) {
      emit(GetUserProfileSuccess());
      final data = value.data["data"];
      userInfoMap.clear();
      UserInfoModel userInfo = UserInfoModel.fromJson(data);
      userInfoMap.addAll({
        AppString.userId: userInfo.userId,
        AppString.userName2: userInfo.userName,
        AppString.userEmail: userInfo.userEmail,
        AppString.address: userInfo.address,
        AppString.image: userInfo.image,
        AppString.lat: userInfo.lat,
        AppString.lng: userInfo.lng,
      });
    }).catchError((error) {
      if (error is DioException) {
        return;
      }
      emit(GetUserProfileFailed());
    });
  }

  ///--------set user image function------->
  File? userImage;
  final ImagePicker imgPicker = ImagePicker();
  Future<File?> getUserImage() async {
    try {
      final XFile? camImage = await imgPicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      // to check that the user picked image
      if (camImage != null) {
        emit(PickImageStateSuccess());
        userImage = File(camImage.path); // turn the path into a file
        // send the userImage to be saved locally..
        await saveUserImageToPrefs(userImage!);
        return userImage;
      } else {
        // if the user cancelled the pick ..
        return null;
      }
    } catch (e) {
      emit(PickImageStateFailed("Failed to pick image: $e"));
      return null;
    }
  }

  ///------save user image to shared preferences------>
  Future<void> saveUserImageToPrefs(File image) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // تحويل الصورة إلى بايتس
      final imageBytes = await image.readAsBytes();
      // تحويل البايتس إلى Base64 String
      final base64Image = base64Encode(imageBytes);
      // حفظ الصورة في SharedPreferences
      await prefs.setString(SharedKeys.photoUrl, base64Image);
    } catch (e) {
      debugPrint("Error saving image: $e");
    }
  }

  /// get the device token to integrate with firebase messaging -------->
  Future<void> getDeviceToken() async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    debugPrint("====================================");
    debugPrint(deviceToken);
  }
}
