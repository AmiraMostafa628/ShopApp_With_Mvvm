import 'dart:async';
import 'dart:ffi';
import 'package:clean_architecture/domain/model/models.dart';
import 'package:clean_architecture/domain/usecase/home_use_case.dart';
import 'package:clean_architecture/presentation/base/baseviewmodel.dart';
import 'package:clean_architecture/presentation/common/state_renderer.dart';
import 'package:clean_architecture/presentation/common/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInput,HomeViewModelOutput{

  final StreamController _homeDataObjectStreamController = BehaviorSubject<HomeData>();

  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    getHomeData();
  }

  getHomeData() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void))
        .fold((failure) => {
      //left => failure
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message))
    },
            (homeObject){
          //right => data(success)
              inputState.add(ContentState());
          inputHomeData.add(homeObject.data);
        });
  }

  @override
  void dispose() {
    _homeDataObjectStreamController.close();
    super.dispose();
  }
  // -- inputs
  @override
  Sink get inputHomeData => _homeDataObjectStreamController.sink;


  // -- outputs

  @override
  Stream<HomeData> get outHomeData =>_homeDataObjectStreamController.stream.map((homeData) => homeData);
}

abstract class HomeViewModelInput{
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput{
  Stream<HomeData> get outHomeData;

}