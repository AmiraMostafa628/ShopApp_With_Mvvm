import 'package:clean_architecture/app/constants.dart';
import 'package:clean_architecture/presentation/common/state_renderer.dart';
import 'package:clean_architecture/presentation/resoures/string_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class FlowStates{
  StateRendererType getStateRenderer();
  String getMessage();

}
//loading state (popup, full screen)

class LoadingState extends FlowStates{

  StateRendererType stateRendererType;
  String? message;

  LoadingState({required this.stateRendererType,
    String message=AppStrings.loading});

  @override
  StateRendererType getStateRenderer()=>stateRendererType;

  @override
  String getMessage()=>message ?? AppStrings.loading.tr();

}
//success state (popup, full screen)

class SuccessState extends FlowStates{

  String message;

  SuccessState({required this.message});

  @override
  StateRendererType getStateRenderer()=>StateRendererType.popupSuccessState;

  @override
  String getMessage()=>message;

}

//error state (popup, full screen)

class ErrorState extends FlowStates{

  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType,this.message);

  @override
  StateRendererType getStateRenderer()=>stateRendererType;

  @override
  String getMessage()=>message;

}

//content state

class ContentState extends FlowStates{

  ContentState();

  @override
  StateRendererType getStateRenderer()=>StateRendererType.contentState;

  @override
  String getMessage()=>Constants.empty;

}

//empty state

class EmptyState extends FlowStates{

  String message;

  EmptyState(this.message);

  @override
  StateRendererType getStateRenderer()=>StateRendererType.fullScreenEmptyState;

  @override
  String getMessage()=>message;

}

extension FlowStatesExtension on FlowStates{
  Widget getScreenWidget(BuildContext context,Widget contentScreenWidget,Function retryActionFunction)
  {
      switch(runtimeType)
      {
        case LoadingState:{
          //popup loading State
          if(getStateRenderer()==StateRendererType.popupLoadingState)
            {
              showPopUp(context, getStateRenderer(), getMessage());

              //show ui content of the Screen
              return contentScreenWidget;
            }
          else //full Screen loading state
            {
              return StateRenderer(
                  stateRendererType: getStateRenderer(),
                  title: AppStrings.loading.tr(),
                  message: getMessage(),
                  retryActionFunction: retryActionFunction);
            }
        }
        case SuccessState:{
          //popup success State
            dismissDialog(context);
            showPopUp(context, getStateRenderer(), getMessage(), title: AppStrings.success.tr(),);

            return contentScreenWidget;
          }

        case ErrorState:{
          //popup error State
          dismissDialog(context);
          if(getStateRenderer()==StateRendererType.popupErrorState)
          {
            showPopUp(context, getStateRenderer(), getMessage());

            //show ui content of the Screen
            return contentScreenWidget;
          }
          else //full Screen error state
          {
            return StateRenderer(
                stateRendererType: getStateRenderer(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
        case EmptyState:{
          return StateRenderer(
              stateRendererType: getStateRenderer(),
              message: getMessage(),
              retryActionFunction: (){});
        }
        case ContentState:{
          dismissDialog(context);
          return contentScreenWidget;
        }
        default:{
          dismissDialog(context);
          return contentScreenWidget;
        }
      }
  }

  _isCurrentDialogShown(BuildContext context)
  => ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context){
    if(_isCurrentDialogShown(context))
      {
        Navigator.of(context,rootNavigator: true).pop(true);
      }
  }

  showPopUp(
      BuildContext context,
      StateRendererType stateRendererType,
      String message,
      {String title = Constants.empty})
  {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (BuildContext context)=>
              StateRenderer(
                  stateRendererType: stateRendererType,
                  message: message,
                  title: title,
                  retryActionFunction: (){}),
      );
    });
  }
}