import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/layout/social_layout_screen.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/modules/login/login_screen.dart';
import '../../shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state)
        {
          if(state is LoginUserCreateSuccessState)
          {
            showToast(text: 'Register Successfully', state: ToastStates.SUCCESS,);
            navigateAndFinish(context, SocialLayoutScreen());
          }
          else if(state is RegisterGetErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR,);
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
                            'Register',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            prefix: IconlyBroken.profile,
                            label: 'Name',
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Name Must not be Empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
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
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            prefix: IconlyBroken.call,
                            label: 'Phone',
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Phone Must not be Empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              prefix: Icons.lock_outlined,
                              isPassword: cubit.isPassword,
                              suffix: cubit.suffix,
                              suffixPressed: ()
                              {
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
                            condition: state is! RegisterGetLoadingState,
                            builder: (BuildContext context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).getRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'register',
                            ),
                            fallback: (BuildContext context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
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
