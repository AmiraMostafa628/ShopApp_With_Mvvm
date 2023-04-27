import 'package:clean_architecture/app/di.dart';
import 'package:clean_architecture/presentation/common/state_renderer_impl.dart';
import 'package:clean_architecture/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:clean_architecture/presentation/resoures/assets_manager.dart';
import 'package:clean_architecture/presentation/resoures/color_manager.dart';
import 'package:clean_architecture/presentation/resoures/string_manager.dart';
import 'package:clean_architecture/presentation/resoures/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {

  final ForgetPasswordViewModel _viewModel =instance<ForgetPasswordViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final _formKey=GlobalKey<FormState>();

  void bind(){
    _viewModel.start();
    _emailController.addListener(() => _viewModel.setPassword(_emailController.text));
  }
  @override
  void initState() {
    bind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowStates>(
        stream: _viewModel.outputState,
        builder: (context,snapshot){
          return snapshot.data?.getScreenWidget(context,_getContent(),(){
            _viewModel.resetPassword();
          })?? _getContent();

        },
      )

    );
  }

  Widget _getContent(){
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p90,left: AppPadding.p28,right: AppPadding.p28),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage (ImageAssets.splashLogo)),
              const SizedBox(
                height: AppSize.s28,
              ),
              StreamBuilder<bool>(
                  stream: _viewModel.outsEmailValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:  InputDecoration(
                        hintText: AppStrings.email.tr(),
                        labelText: AppStrings.email.tr(),
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.invalidEmail.tr(),
                      ),
                    );
                  }
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              StreamBuilder<bool>(
                  stream: _viewModel.allOutputValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: (snapshot.data?? false)?(){
                        _viewModel.resetPassword();
                      }:null,
                          child: Text(AppStrings.resetPassword.tr()) ),
                    );
                  }
              ),
              TextButton(onPressed: (){
                /* Navigator.pushReplacementNamed(context, Routes.registerRoute);*/
              },
                child:Text(
                  AppStrings.resend.tr(),
                  style: Theme.of(context).textTheme.titleMedium,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
