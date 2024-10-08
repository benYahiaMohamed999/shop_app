abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLodingState extends LoginState {}

class LoginSuccesState extends LoginState {
  final ShopLoginModel loginModel;

  LoginSuccesState(this.loginModel);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class LoginChangePasswordState extends LoginState {}
