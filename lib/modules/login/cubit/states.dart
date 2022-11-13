abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangePasswordVisibilityState extends LoginStates {}

class RegisterGetLoadingState extends LoginStates {}

class RegisterGetSuccessState extends LoginStates {}

class RegisterGetErrorState extends LoginStates {

  final String error;

  RegisterGetErrorState(this.error);

}




class LoginGetLoadingState extends LoginStates {}

class LoginGetSuccessState extends LoginStates
{
  final String uId;

  LoginGetSuccessState(this.uId);
}

class LoginGetErrorState extends LoginStates {
  final String error;

  LoginGetErrorState(this.error);
}



class LoginUserCreateLoadingState extends LoginStates {}

class LoginUserCreateSuccessState extends LoginStates {}

class LoginUserCreateErrorState extends LoginStates {

  final String error;

  LoginUserCreateErrorState(this.error);

}