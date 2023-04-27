import 'dart:async';
import 'package:clean_architecture/domain/usecase/login_use_case.dart';
import 'package:clean_architecture/presentation/base/baseviewmodel.dart';
import 'package:clean_architecture/presentation/common/freezed_data_classes.dart';
import 'package:clean_architecture/presentation/common/state_renderer.dart';
import 'package:clean_architecture/presentation/common/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs,LoginViewModelOutputs{

 final StreamController _userNameStreamController = StreamController<String>.broadcast();
 final StreamController _passwordStreamController = StreamController<String>.broadcast();
 final StreamController _areAllInputsValidController = StreamController<void>.broadcast();
 final StreamController isUserLoggedInSuccessfully = StreamController<bool>();



  var loginObject = LoginObject("","");
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  // input
  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidController.close();
    isUserLoggedInSuccessfully.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }
 //input
  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

 @override
 Sink get inputAreAllDataValid => _areAllInputsValidController.sink;

 @override
 setPassword(String password) {
   inputPassword.add(password);
   loginObject=loginObject.copyWith(password: password);
   inputAreAllDataValid.add(null);

 }

 @override
 setUserName(String userName) {
   inputUserName.add(userName);
   loginObject=loginObject.copyWith(userName: userName);
   inputAreAllDataValid.add(null);
 }


 //outputs
  @override
  Stream<bool> get outsPasswordValid =>
      _passwordStreamController.stream.map((password) => _passwordValid(password));

  @override
  Stream<bool> get outsUserNameValid =>
      _userNameStreamController.stream.map((userName) => _userNameValid(userName));

 @override
 Stream<bool> get outsAreAllDataValid =>
     _areAllInputsValidController.stream.map((_) => _areAllInputsValid());


 //private function

  bool _passwordValid(String password)
  {
    return password.isNotEmpty;
  }

  bool _userNameValid(String userName)
  {
    return userName.isNotEmpty;
  }

  bool _areAllInputsValid()
  {
    return _userNameValid(loginObject.userName) && _passwordValid(loginObject.password);
  }


 @override
 login() async{
   inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
   (await _loginUseCase.execute(
       LoginUseCaseInput(loginObject.userName, loginObject.password)))
       .fold((failure) => {
     //left => failure
     inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message))
   },
           (data){
         //right => data(success)
         inputState.add(ContentState());
         isUserLoggedInSuccessfully.add(true);
       });
 }
}

abstract class LoginViewModelInputs{

  setUserName(String userName);
  setPassword(String password);
  login();
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAreAllDataValid;
}

abstract class LoginViewModelOutputs{

  Stream<bool> get outsUserNameValid;
  Stream<bool> get outsPasswordValid;
  Stream<bool> get outsAreAllDataValid;
}