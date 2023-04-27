import 'dart:async';
import 'dart:ffi';
import 'package:clean_architecture/domain/model/models.dart';
import 'package:clean_architecture/domain/usecase/store_details_use_case.dart';
import 'package:clean_architecture/presentation/base/baseviewmodel.dart';
import 'package:clean_architecture/presentation/common/state_renderer.dart';
import 'package:clean_architecture/presentation/common/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel with StoreDetailsViewModelInputs,StoreDetailsViewModelOutputs{

  final StreamController _storeDetailsStreamController = BehaviorSubject<StoresDetailsObject>();

  final StoreDetailsUseCase _storeDetailsUseCase;

  StoreDetailsViewModel(this._storeDetailsUseCase);

  @override
  void start() {
    getStoreDetailsData();
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  @override
  Sink get storeDetailsInput =>_storeDetailsStreamController.sink;

  getStoreDetailsData() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _storeDetailsUseCase.execute(Void))
        .fold((failure) => {
      //left => failure
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message))
    },
            (storeDetailsObject){
          //right => data(success)
          inputState.add(ContentState());
          storeDetailsInput.add(storeDetailsObject);
        });
  }

  @override
  Stream<StoresDetailsObject> get storeDetailsOutputs =>
      _storeDetailsStreamController.stream.map((storeDetails) => storeDetails);
}

abstract class StoreDetailsViewModelInputs{
  Sink get storeDetailsInput;
}

abstract class StoreDetailsViewModelOutputs{
  Stream<StoresDetailsObject> get storeDetailsOutputs;
}