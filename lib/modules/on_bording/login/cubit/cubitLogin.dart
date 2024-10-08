import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/module/Shop_app/login_model.dart';
import 'package:test_app/modules/on_bording/login/cubit/stateLogin.dart';
import 'package:test_app/shared/componet/componet.dart';
import 'package:test_app/shared/local/remote/dio_helper.dart';

import '../../../../shared/network/end_points.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel? loginModel;

  userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLodingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
      token: token,
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(value.data);
      print(loginModel!.data.token);
      emit(LoginSuccesState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });
  }

  Icon suffix = const Icon(Icons.visibility);
  bool isPasswordShown = true;
  void changePasswordVisibilte() {
    isPasswordShown = !isPasswordShown;

    suffix = isPasswordShown
        ? const Icon(Icons.visibility_off)
        : const Icon(Icons.visibility);
    emit(LoginChangePasswordState());
  }
}
