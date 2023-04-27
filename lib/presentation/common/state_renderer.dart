import 'package:clean_architecture/app/constants.dart';
import 'package:clean_architecture/presentation/resoures/assets_manager.dart';
import 'package:clean_architecture/presentation/resoures/color_manager.dart';
import 'package:clean_architecture/presentation/resoures/string_manager.dart';
import 'package:clean_architecture/presentation/resoures/style_manager.dart';
import 'package:clean_architecture/presentation/resoures/values_manager.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType{
  //popup states (dialog)
  popupLoadingState,
  popupSuccessState,
  popupErrorState,

  //full screen state
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  //general
  contentState

}
class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer({
    required this.stateRendererType,
    this.message = AppStrings.loading,
    this.title=Constants.empty,
    required this.retryActionFunction,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context){

     switch(stateRendererType)
     {

       case StateRendererType.popupLoadingState:
         return _getPopUoDialog(context,[_getAnimatedImage(JsonAssets.loading)]);

       case StateRendererType.popupSuccessState:
         return _getPopUoDialog(context,[
           _getAnimatedImage(JsonAssets.success),
           _getMessage(title),
           _getMessage(message),
           _getButtonAction(AppStrings.ok.tr(), context)
         ]);

       case StateRendererType.popupErrorState:
         return _getPopUoDialog(context, [
           _getAnimatedImage(JsonAssets.error),
           _getMessage(message),
           _getButtonAction(AppStrings.ok.tr(),context),
         ]);

       case StateRendererType.fullScreenLoadingState:
         return getItemsColumn([
           _getAnimatedImage(JsonAssets.loading),
           _getMessage(AppStrings.loading.tr()),
         ]);

       case StateRendererType.fullScreenErrorState:
         return getItemsColumn([
           _getAnimatedImage(JsonAssets.error),
           _getMessage(message),
           _getButtonAction(AppStrings.retryAgain.tr(),context),
         ]);

       case StateRendererType.fullScreenEmptyState:
         return getItemsColumn([
           _getAnimatedImage(JsonAssets.empty),
           _getMessage(message),
         ]);

       case StateRendererType.contentState:
         return Container();

       default:
         return Container();

     }
  }




  Widget _getPopUoDialog(BuildContext context,List<Widget>children){
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow:const [
             BoxShadow(
              color: Colors.black26,
          )
          ]
        ),
        child:_getDialogContext(context,children),
      ),

    );
  }
  Widget _getDialogContext(BuildContext context,List<Widget>children){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget getItemsColumn(List<Widget>children){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName)
  {
    return SizedBox(
        height: AppSize.s100,
        width: AppSize.s100,
        child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message)
  {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Text(
          message,
          style: getRegularStyle(color: ColorManager.black,fontSize: AppSize.s18),
        ),
      ),
    );
  }

  Widget _getButtonAction(String buttonTitle,BuildContext context)
  {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: (){
                if(stateRendererType == StateRendererType.fullScreenErrorState)
                  {
                    // call retry function
                    retryActionFunction.call();
                  }
                else //popup error state
                  {
                    Navigator.of(context).pop();
                  }
              },
              child:Text(buttonTitle) ),
        ),
      ),
    );
  }


}
