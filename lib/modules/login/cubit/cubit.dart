import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user/user_model.dart';
import 'package:social_app/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(LoginChangePasswordVisibilityState());
  }

  void getLogin({
    required String email,
    required String password,
  }) {
    emit(LoginGetLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);

      emit(LoginGetSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginGetErrorState(error.toString()));
    });
  }

  void getRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterGetLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);

      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      emit(RegisterGetErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    emit(LoginUserCreateLoadingState());

    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'Write Your Bio ...',
      image: 'https://cdn-icons-png.flaticon.com/512/945/945120.png?w=740&t=st=1668173720~exp=1668174320~hmac=25dc01bdea1e260d758d780a3ae6e8830676b6d44b4ff2b20587c061e864725c',
      cover: 'https://img.freepik.com/premium-photo/indoor-shot-happy-curly-haired-young-woman-wears-sunglasses-casual-t-shirt-looks-gladfully-away-has-good-mood-isolated-beige-background-positive-human-emotions-style-concept_273609-62610.jpg?w=740',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(LoginUserCreateSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LoginUserCreateErrorState(error.toString()));
    });
  }
}
