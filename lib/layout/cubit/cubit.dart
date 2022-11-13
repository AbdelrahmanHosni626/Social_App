import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/user/users_screen.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../models/user/user_model.dart';
import '../../shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  int currentIndex = 0;

  void changeNavBar(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavBarState());
    }
  }

  SocialUserModel? userModel;

  void getUserData() {
    uId = CacheHelper.getData(key: 'uId');
    print('when start function $uId');
    emit(SocialGetUserDataLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserDataErrorState(error.toString()));
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickerSuccessState());
    } else {
      emit(SocialProfileImagePickerErrorState());
    }
  }

  File? coverImage;
  var coverPicker = ImagePicker();

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickerSuccessState());
    } else {
      emit(SocialCoverImagePickerErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {

    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
        // emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {

    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
        // emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUpdateUserLoadingState());
  //
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null || profileImage != null) {
  //   } else {
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    {
      SocialUserModel model = SocialUserModel(
        name: name,
        email: userModel!.name,
        phone: phone,
        bio: bio,
        image: image ?? userModel!.image,
        cover: cover ?? userModel!.cover,
        uId: userModel!.uId,
        isEmailVerified: false,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .update(model.toMap())
          .then((value) {
        getUserData();
      }).catchError((error) {
        emit(SocialUpdateUserErrorState());
      });
    }
  }
}
