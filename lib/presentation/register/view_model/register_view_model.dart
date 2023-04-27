import 'dart:async';
import 'dart:io';
import 'package:clean_architecture/app/function.dart';
import 'package:clean_architecture/domain/usecase/register_use_case.dart';
import 'package:clean_architecture/presentation/base/baseviewmodel.dart';
import 'package:clean_architecture/presentation/common/freezed_data_classes.dart';
import 'package:clean_architecture/presentation/common/state_renderer.dart';
import 'package:clean_architecture/presentation/common/state_renderer_impl.dart';
import 'package:clean_architecture/presentation/resoures/string_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInput,RegisterViewModelOutput{

  StreamController userNameStreamController = StreamController<String>.broadcast();
  StreamController mobileNumberStreamController = StreamController<String>.broadcast();
  StreamController emailController = StreamController<String>.broadcast();
  StreamController passwordStreamController = StreamController<String>.broadcast();
  StreamController profilePictureStreamController = StreamController<File>.broadcast();
  StreamController areAllInputValidStreamController = StreamController<void>.broadcast();
  final StreamController isUserRegisterInSuccessfully = StreamController<bool>();

  final RegisterUseCase  _registerUseCase;
  RegisterViewModel(this._registerUseCase);

  var registerObject = RegisterObject("", "", "", "", "", "");

  @override
  void start() {
    // TODO: implement start
  }
  @override
  void dispose() {
    userNameStreamController.close();
    mobileNumberStreamController.close();
    emailController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    areAllInputValidStreamController.close();
    isUserRegisterInSuccessfully.close();
    super.dispose();
  }
  //input
  @override
  Sink get inputUserName => userNameStreamController.sink;

  @override
  Sink get inputMobileNumber => mobileNumberStreamController.sink;

  @override
  Sink get inputEmail => emailController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  Sink get inputAreAllDataValid => areAllInputValidStreamController.sink;



  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if(_isUserNameValid(userName)){
        // update register view object
        registerObject= registerObject.copyWith(userName: userName);
      }
    else{
         //reset username value in register view object
        registerObject= registerObject.copyWith(userName: "");
      }
  }

  @override
  setCountryMobileCode( countryMobileCode) {
    if(countryMobileCode.isNotEmpty){
      // update register view object
      registerObject= registerObject.copyWith(countryMobileCode: countryMobileCode);
    }
    else{
      //reset countryMobileCode value in register view object
      registerObject= registerObject.copyWith(countryMobileCode: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if(isEmailValid(email)){
      // update register view object
      registerObject= registerObject.copyWith(email: email);
    }
    else{
      //reset email value in register view object
      registerObject= registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if(_isMobileNumberValid(mobileNumber)){
      // update register view object
      registerObject= registerObject.copyWith(mobileNumber: mobileNumber);
    }
    else{
      //reset mobileNumber value in register view object
      registerObject= registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if(_isPasswordValid(password)){
      // update register view object
      registerObject= registerObject.copyWith(password: password);
    }
    else{
      //reset password value in register view object
      registerObject= registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if(profilePicture.path.isNotEmpty){
      // update register view object
      registerObject= registerObject.copyWith(profilePicture: profilePicture.path);
    }
    else{
      //reset profilePicture value in register view object
      registerObject= registerObject.copyWith(profilePicture: "");
    }
    validate();
  }


  //output
  @override
  Stream<bool> get outputIsUserNameValid =>
      userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName =>
      outputIsUserNameValid.map((isUserName) => isUserName? null: AppStrings.userNameInvalid.tr() );

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      mobileNumberStreamController.stream.map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobileNumber) =>
      isMobileNumber? null : AppStrings.mobileNumberInvalid.tr());

  @override
  Stream<bool> get outputIsEmailValid =>
      emailController.stream.map((email) => isEmailValid(email));


  @override
  Stream<String?> get outputErrorEmail =>
      outputIsEmailValid.map((isEmail) =>
     isEmail? null : AppStrings.invalidEmail.tr());

  @override
  Stream<bool> get outputIsPasswordValid =>
      passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword =>
      outputIsPasswordValid.map((isPassword) =>
      isPassword? null : AppStrings.passwordInvalid.tr());

  @override
  Stream<File> get outputProfilePicture =>
      profilePictureStreamController.stream.map((file) => file);


  @override
  Stream<bool> get outputAreAllDataValid =>
      areAllInputValidStreamController.stream.map((_) => _areAllInputsValid());


  //private functions

 bool _isUserNameValid(String userName)
  {
    return userName.length >= 8;
  }

  bool _isMobileNumberValid(String mobileNumber)
  {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password)
  {
    return password.length >= 6;
  }

  bool _areAllInputsValid()
  {
    return registerObject.userName.isNotEmpty &&
           registerObject.countryMobileCode.isNotEmpty &&
           registerObject.mobileNumber.isNotEmpty &&
           registerObject.email.isNotEmpty &&
           registerObject.password.isNotEmpty &&
           registerObject.profilePicture.isNotEmpty;

  }

  validate()
  {
    inputAreAllDataValid.add(null);
  }

  @override
  register() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _registerUseCase.execute(
        RegisterUseCaseInput(
          registerObject.userName,
          registerObject.countryMobileCode,
          registerObject.mobileNumber,
          registerObject.email,
          registerObject.password,
          registerObject.profilePicture
        )))
        .fold((failure) => {
      //left => failure
      inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message))
    },
            (data){
          //right => data(success)
          inputState.add(ContentState());
          isUserRegisterInSuccessfully.add(true);
        });
  }

}

abstract class RegisterViewModelInput {
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAreAllDataValid;
  
  register();
  
  setUserName(String userName);
  setCountryMobileCode(String countryMobileCode);
  setMobileNumber(String mobileNumber);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);
}

abstract class RegisterViewModelOutput{
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File> get outputProfilePicture;
  Stream<bool> get outputAreAllDataValid;
}