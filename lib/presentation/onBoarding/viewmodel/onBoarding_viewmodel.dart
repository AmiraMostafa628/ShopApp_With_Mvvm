import 'dart:async';
import 'package:clean_architecture/presentation/base/baseviewmodel.dart';
import 'package:clean_architecture/domain/model/models.dart';
import 'package:clean_architecture/presentation/resoures/assets_manager.dart';
import 'package:clean_architecture/presentation/resoures/string_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs,OnBoardingViewModelOutputs{
  //stream Controller output
  final StreamController _streamController = StreamController<SliderViewObject>();
  int _currentIndex=0;

  late final List<SliderObject> _list;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    // viewmodel start your job
    _list=_getSliderData();
    _postDataToView();


  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if(nextIndex == _list.length) {
       nextIndex = 0;
    }

    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if(previousIndex==-1) {
      previousIndex = _list.length-1;
    }

    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex=index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject
   => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // onBoarding private function

  void _postDataToView(){
    inputSliderViewObject
        .add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  List<SliderObject> _getSliderData()=> [
    SliderObject(
        AppStrings.onBoardingTitle1.tr(),AppStrings.onBoardingSubTitle1.tr(),ImageAssets.onBoardingLogo1),
    SliderObject(
        AppStrings.onBoardingTitle2.tr(),AppStrings.onBoardingSubTitle2.tr(),ImageAssets.onBoardingLogo2),
    SliderObject(
        AppStrings.onBoardingTitle3.tr(),AppStrings.onBoardingSubTitle3.tr(),ImageAssets.onBoardingLogo3),
    SliderObject(
        AppStrings.onBoardingTitle4.tr(),AppStrings.onBoardingSubTitle4.tr(),ImageAssets.onBoardingLogo4),
  ];
}

//inputs means "order" that our view model will recieve from view
abstract class OnBoardingViewModelInputs{
  int goNext(); // when user clicks on right arrow or swipe left
  int goPrevious(); // when user clicks on left arrow or swipe right
  void onPageChanged(int index);

//stream Controller input
  Sink get inputSliderViewObject;
  
}

abstract class OnBoardingViewModelOutputs{
  //stream Controller output
  Stream<SliderViewObject> get outputSliderViewObject;
}