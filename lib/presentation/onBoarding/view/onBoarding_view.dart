import 'package:clean_architecture/app/app_prefs.dart';
import 'package:clean_architecture/app/di.dart';
import 'package:clean_architecture/domain/model/models.dart';
import 'package:clean_architecture/presentation/onBoarding/viewmodel/onBoarding_viewmodel.dart';
import 'package:clean_architecture/presentation/resoures/assets_manager.dart';
import 'package:clean_architecture/presentation/resoures/color_manager.dart';
import 'package:clean_architecture/presentation/resoures/constant_Manager.dart';
import 'package:clean_architecture/presentation/resoures/routes_manager.dart';
import 'package:clean_architecture/presentation/resoures/string_manager.dart';
import 'package:clean_architecture/presentation/resoures/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';


class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel =OnBoardingViewModel();
  final AppPreferences _appPreferences =instance<AppPreferences>();

  void bind()
  {
    _viewModel.start();
    _appPreferences.setOnBoardingViewed();
  }
  @override
  void initState() {
    bind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
        builder: ((context, snapshot) {
          return getContentWidget(snapshot.data);
        }));
  }

  Widget getContentWidget(SliderViewObject?  sliderViewObject){
    if(sliderViewObject==null) {
        return Container();
    } else {
        return Scaffold(
         backgroundColor: ColorManager.white,
         appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle:  SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,

        ),
      ),
          body: PageView.builder(
             controller: _pageController,
             itemCount: sliderViewObject.numOfSlides,
             onPageChanged: (index){
            _viewModel.onPageChanged(index);
          },
            itemBuilder:(context,index){
              return OnBoardingPage(sliderViewObject.sliderObject);
          }) ,
           bottomSheet: Container(
              color: ColorManager.white,
              height: AppSize.s100,
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.loginRoute);
                      },
                  child: Text(AppStrings.skip.tr(),textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleMedium,),

              ),
            ),
              _onBottomSheetWidget(sliderViewObject),
          ],

        ),

      ),
    );
    }
  }

  Widget _onBottomSheetWidget(SliderViewObject sliderViewObject)
  {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: GestureDetector(
              onTap: (){
                //go to previous slide

                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration: Duration(milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrow),
              ),
            ),
          ),
          //circle Indicator
          Row(
            children: [
              for(int i =0; i<sliderViewObject.numOfSlides; i++)
                Padding(padding: EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                )

            ],
          ),

          //right arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: GestureDetector(
              onTap: (){
                //go to next slide
                _pageController.animateToPage(_viewModel.goNext(),
                    duration: const Duration(milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrow),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index,int _currentIndex)
  {
    if(index ==_currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircle);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircle);
    }
  }
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;
  const OnBoardingPage(this._sliderObject,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children:
      [
        SizedBox(height: AppSize.s1_5.h,),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTile,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        SizedBox(height: AppSize.s6.h,),
        SvgPicture.asset(_sliderObject.image,),

      ],
    );
  }
}




