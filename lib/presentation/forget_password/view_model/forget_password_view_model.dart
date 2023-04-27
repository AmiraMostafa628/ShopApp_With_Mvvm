import 'dart:async';
import 'package:clean_architecture/app/function.dart';
import 'package:clean_architecture/domain/usecase/forget_password_use_case.dart';
import 'package:clean_architecture/presentation/base/baseviewmodel.dart';
import 'package:clean_architecture/presentation/common/state_renderer.dart';
import 'package:clean_architecture/presentation/common/state_renderer_impl.dart';


class ForgetPasswordViewModel extends BaseViewModel with ForgetPasswordViewModelInputs,ForgetPasswordViewModelOutputs{

  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
  StreamController<void>.broadcast();

  final ForgetPasswordUseCase forgetPasswordUseCase;
  ForgetPasswordViewModel(this.forgetPasswordUseCase);

  var email = "";

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get allInputValid => _isAllInputValidStreamController.sink;
  
  @override
  Stream<bool> get outsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get allOutputValid =>
      _isAllInputValidStreamController.stream.map((isAllInputValid) => _isAllInputValid());


  @override
  resetPassword() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    return (await forgetPasswordUseCase.execute(email)).fold((failure) => {
    //left => failure
      inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message))
    },
    (supportMessage){
    //right => data(success)
      inputState.add(SuccessState(message: supportMessage));
    });
  }

  @override
  setPassword(String email) {
    inputEmail.add(email);
   this.email = email;
    _validate();
  }

  _isAllInputValid() {
    return isEmailValid(email);
  }

  _validate() {
    allInputValid.add(null);
  }
}


abstract class ForgetPasswordViewModelInputs{

  setPassword(String email);
  resetPassword();
  Sink get inputEmail;
  Sink get allInputValid;
}

abstract class ForgetPasswordViewModelOutputs{

  Stream<bool> get outsEmailValid;
  Stream<bool> get allOutputValid;
}