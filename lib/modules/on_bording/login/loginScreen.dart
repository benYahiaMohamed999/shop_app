import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/modules/on_bording/login/cubit/cubitLogin.dart';
import 'package:test_app/modules/on_bording/login/cubit/stateLogin.dart';
import 'package:test_app/shared/componet/componet.dart';
import 'package:test_app/shared/local/cache_Helper.dart';

import '../../../layout/ShopLayout.dart';
import '../../register/registerScreen.dart';

class LoginScrren extends StatelessWidget {
  LoginScrren({super.key});

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
          if (state is LoginSuccesState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                navigateAndFinsh(
                  context,
                  ShopLayout(),
                );
              });
            } else {
              print(state.loginModel.message.toString());

              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Enter your E-mail Adress',
                            labelText: 'E-mail',
                            prefix: Image(
                                width: 30,
                                height: 25,
                                image: AssetImage(
                                  'assets/images/email.png',
                                )),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (index) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your E-mail Address';
                            }
                          },
                          controller: emailController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          obscureText: LoginCubit.get(context).isPasswordShown,
                          decoration: InputDecoration(
                            hintText: 'Enter your Password',
                            labelText: 'Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                LoginCubit.get(context)
                                    .changePasswordVisibilte();
                              },
                              child: LoginCubit.get(context).suffix,
                            ),
                            prefix: const Image(
                                width: 30,
                                height: 30,
                                image: AssetImage(
                                  'assets/images/password.png',
                                )),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (index) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Password is to short';
                            }
                          },
                          controller: passwordController,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                          condition: State is! LoginLodingState,
                          builder: (context) => Container(
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ), //BorderRadius.all:
                            ),
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: TextButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  'LOGIN',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account? ',
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: const Text(
                                'REGISTER',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
