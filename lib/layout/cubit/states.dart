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


// Get Profile Image
class SocialProfileImagePickerSuccessState extends SocialStates {}

class SocialProfileImagePickerErrorState extends SocialStates {}

// Get Cover Image
class SocialCoverImagePickerSuccessState extends SocialStates {}

class SocialCoverImagePickerErrorState extends SocialStates {}


// Upload Profile Image
class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

// Upload Cover Image
class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

// Update User Data
class SocialUpdateUserLoadingState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}


// Create Post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

// Get Post Image
class SocialPostImagePickerSuccessState extends SocialStates {}

class SocialPostImagePickerErrorState extends SocialStates {}

// Remove Post Image
class SocialRemovePostImageState extends SocialStates {}


// Get posts
class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates
{
  final String error;

  SocialGetPostsErrorState(this.error);
}


// Make Like
class SocialLikePostsSuccessState extends SocialStates {}

class SocialLikePostsErrorState extends SocialStates
{
  final String error;

  SocialLikePostsErrorState(this.error);
}