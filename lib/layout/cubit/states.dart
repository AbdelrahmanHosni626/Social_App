abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserDataLoadingState extends SocialStates {}

class SocialGetUserDataSuccessState extends SocialStates {}

class SocialGetUserDataErrorState extends SocialStates
{
  final String error;

  SocialGetUserDataErrorState(this.error);
}

class SocialChangeBottomNavBarState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickerSuccessState extends SocialStates {}

class SocialProfileImagePickerErrorState extends SocialStates {}

class SocialCoverImagePickerSuccessState extends SocialStates {}

class SocialCoverImagePickerErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUpdateUserLoadingState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}