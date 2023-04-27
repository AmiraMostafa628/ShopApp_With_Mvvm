import 'package:clean_architecture/app/app_prefs.dart';
import 'package:clean_architecture/app/di.dart';
import 'package:clean_architecture/presentation/common/state_renderer_impl.dart';
import 'package:clean_architecture/presentation/login/viewmodel/login_view_model.dart';
import 'package:clean_architecture/presentation/resoures/assets_manager.dart';
import 'package:clean_architecture/presentation/resoures/color_manager.dart';
import 'package:clean_architecture/presentation/resoures/routes_manager.dart';
import 'package:clean_architecture/presentation/resoures/string_manager.dart';
import 'package:clean_architecture/presentation/resoures/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  final AppPreferences _appPreferences =instance<AppPreferences>();

  final _formKey=GlobalKey<FormState>();


  _bind()
  {
    _viewModel.start();
    _userNameController.addListener(() =>_viewModel.setUserName(_userNameController.text));
    _passwordController.addListener(() =>_viewModel.setPassword(_passwordController.text));
    _viewModel.isUserLoggedInSuccessfully.stream.listen((event) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _appPreferences.setIsUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowStates>(
        stream: _viewModel.outputState,
        builder: (context,snapshot){
          return snapshot.data?.getScreenWidget(context,_getContentWidget(),(){
            _viewModel.login();
          })?? _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget()
  {
    return Padding(
        padding: const EdgeInsets.only(top: AppPadding.p90,left: AppPadding.p28,right: AppPadding.p28),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children:  [
                 const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
                 const SizedBox(height: AppSize.s28,),
                 StreamBuilder<bool>(
                   stream: _viewModel.outsUserNameValid,
                   builder: (context,snapshot){
                     return TextFormField(
                       controller: _userNameController,
                       keyboardType: TextInputType.emailAddress,
                       decoration: InputDecoration(
                         hintText: AppStrings.userName.tr(),
                         labelText: AppStrings.userName.tr(),
                         errorText: (snapshot.data?? true)?null:AppStrings.userNameError.tr(),
                       ),
                       );
                   }
                 ),
                 const SizedBox(height: AppSize.s16,),
                 StreamBuilder<bool>(
                    stream: _viewModel.outsPasswordValid,
                    builder: (context,snapshot){
                      return TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: AppStrings.password.tr(),
                          labelText: AppStrings.password.tr(),
                          errorText: (snapshot.data?? true)?null:AppStrings.passwordError.tr(),
                        ),
                      );
                    }
                ),
                 const SizedBox(height: AppSize.s28,),
                 StreamBuilder<bool>(
                    stream: _viewModel.outsAreAllDataValid,
                    builder: (context,snapshot){
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data??false)?(){
                              _viewModel.login();}:null
                              , child: Text(AppStrings.login.tr())),
                      );
                    }
                ),
                 const SizedBox(height: AppSize.s8,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, Routes.forgetPasswordRoute);
                    },
                        child:Text(
                            AppStrings.forgetPassword.tr(),
                            style: Theme.of(context).textTheme.titleMedium,),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, Routes.registerRoute);
                    },
                      child:Text(
                        AppStrings.registerScreen.tr(),
                        style: Theme.of(context).textTheme.titleMedium,),
                    ),
                  ],
                )





              ],
            ),
          ),
        ),
      );

  }
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
