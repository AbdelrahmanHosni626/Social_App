import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/layout/social_layout_screen.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import '../../shared/components/components.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          if (state is LoginGetSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              showToast(text: 'Login Successfully', state: ToastStates.SUCCESS,);
              navigateAndFinish(context, SocialLayoutScreen());
            });
          } else if (state is LoginGetErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = LoginCubit.get(context);

          return GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              prefix: IconlyBroken.message,
                              label: 'Email',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Email Must not be Empty';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              prefix: IconlyBroken.password,
                              isPassword: cubit.isPassword,
                              suffix: cubit.suffix,
                              suffixPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              label: 'Password',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Password Must not be Empty';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginGetLoadingState,
                            builder: (BuildContext context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).getLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'LOGIN',
                            ),
                            fallback: (BuildContext context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                              ),
                              defaultTextButton(
                                function: () {
                                  navigateAndFinish(context, RegisterScreen());
                                },
                                text: 'Register now',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
