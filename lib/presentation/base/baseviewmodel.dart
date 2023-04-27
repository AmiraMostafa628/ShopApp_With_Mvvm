import 'dart:async';

import 'package:clean_architecture/presentation/common/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs{
  //shared variables and function that will be used through any view model
  StreamController inputStreamController = BehaviorSubject<FlowStates>();

  @override
  void dispose() {
    inputStreamController.close();
  }

  @override
  Sink get inputState => inputStreamController.sink;

  @override
  Stream<FlowStates> get outputState
  => inputStreamController.stream.map((flowState) => flowState);

}

abstract class BaseViewModelInputs{
  void start(); //start view model job

  void dispose(); //will be called when view model dies
  Sink get inputState;

}

abstract class BaseViewModelOutputs{
  Stream<FlowStates> get outputState;
}