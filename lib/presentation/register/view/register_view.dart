import 'dart:io';
import 'package:clean_architecture/app/app_prefs.dart';
import 'package:clean_architecture/app/constants.dart';
import 'package:clean_architecture/app/di.dart';
import 'package:clean_architecture/presentation/common/state_renderer_impl.dart';
import 'package:clean_architecture/presentation/register/view_model/register_view_model.dart';
import 'package:clean_architecture/presentation/resoures/assets_manager.dart';
import 'package:clean_architecture/presentation/resoures/color_manager.dart';
import 'package:clean_architecture/presentation/resoures/routes_manager.dart';
import 'package:clean_architecture/presentation/resoures/string_manager.dart';
import 'package:clean_architecture/presentation/resoures/values_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController =TextEditingController();
  final TextEditingController _mobileNumberController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();


  bind(){
    _userNameController.addListener(() {_viewModel.setUserName(_userNameController.text);});
    _mobileNumberController.addListener(() {_viewModel.setMobileNumber(_mobileNumberController.text);});
    _emailController.addListener(() {_viewModel.setEmail(_emailController.text);});
    _passwordController.addListener(() {_viewModel.setPassword(_passwordController.text);});
    _viewModel.isUserRegisterInSuccessfully.stream.listen((event) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _appPreferences.setIsUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
      });
    });
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
        builder: (context,snapshot)
        {
          return snapshot.data?.getScreenWidget(context,_getContentWidget(),
                  (){_viewModel.register();}) ??_getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p28,left: AppPadding.p28,right: AppPadding.p28),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children:  [
              const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
             /* const SizedBox(height: AppSize.s20,),*/
              StreamBuilder<String?>(
                  stream: _viewModel.outputErrorUserName,
                  builder: (context,snapshot){
                    return TextFormField(
                      controller: _userNameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: AppStrings.userName.tr(),
                        labelText: AppStrings.userName.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  }
              ),
              const SizedBox(
                height: AppSize.s16,),
              Row(
                children: [
                  Expanded(flex:1,
                    child:CountryCodePicker(
                    onChanged: (country){
                      _viewModel.setCountryMobileCode(country.dialCode??Constants.token);
                    },
                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                    initialSelection: '+20',
                    favorite: const ['+39','FR','+966'],
                    // optional. Shows only country name and flag
                    showCountryOnly: true,
                    // optional. Shows only country name and flag when popup is closed.
                    showOnlyCountryWhenClosed: true,
                    hideMainText: true,


                  ),),
                  Expanded(flex:4,
                    child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorMobileNumber,
                      builder: (context,snapshot){
                        return TextFormField(
                          controller: _mobileNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: AppStrings.mobileNumber.tr(),
                            labelText: AppStrings.mobileNumber.tr(),
                            errorText: snapshot.data,
                          ),
                        );
                      }
                  ),)
                ],
              ),
              const SizedBox(
                height: AppSize.s16,),
              StreamBuilder<String?>(
                  stream: _viewModel.outputErrorEmail,
                  builder: (context,snapshot){
                    return TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: AppStrings.email.tr(),
                        labelText: AppStrings.email.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  }
              ),
              const SizedBox(
                height: AppSize.s16,),
              StreamBuilder<String?>(
                  stream: _viewModel.outputErrorPassword,
                  builder: (context,snapshot){
                    return TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: AppStrings.password.tr(),
                        labelText: AppStrings.password.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  }
              ),
              const SizedBox(
                height: AppSize.s16,),
              Container(
                height: AppSize.s45,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                  border: Border.all(
                    color: ColorManager.lightGrey,
                  )
                ),
                child: GestureDetector(
                  child: _getMediaWidget(),
                  onTap: (){
                    _showPicker(context);
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,),
              StreamBuilder<bool>(
                  stream: _viewModel.outputAreAllDataValid,
                  builder: (context,snapshot){
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: (snapshot.data??false)?(){
                            _viewModel.register();}:null
                          , child: Text(AppStrings.register.tr())),
                    );
                  }
              ),
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              },
                child:Text(
                  AppStrings.alreadyHaveAccount.tr(),
                  style: Theme.of(context).textTheme.titleMedium,),
              ),
              const SizedBox(height: AppSize.s20,)




            ],
          ),
        ),
      ),
    );

  }

  Widget _getMediaWidget(){
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
           Flexible(child: Text(AppStrings.profilePic.tr(),
          ),),
          Flexible(child: StreamBuilder<File>(
            stream: _viewModel.outputProfilePicture ,
              builder: (context,snapshot){
              return _imagePickedByUser(snapshot.data);
              }
          ),
          ),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCamera)),
        ],
      ),
    );
  }
  _showPicker(BuildContext context)
  {
   showModalBottomSheet(context: context,
       builder: (BuildContext context){
         return SafeArea(
             child: Wrap(
                   children: [
                     ListTile(
                       trailing: const Icon(Icons.arrow_forward),
                       leading: const Icon(Icons.camera),
                       title:  Text(AppStrings.photoGallery.tr()),
                       onTap: (){
                         _imageFromGallery();
                         Navigator.of(context).pop();
                       },
                     ),
                     ListTile(
                        trailing: const Icon(Icons.arrow_forward),
                        leading: const Icon(Icons.camera_alt_outlined),
                        title:  Text(AppStrings.photoCamera.tr()),
                        onTap: (){
                          _imageFromCamera();
                          Navigator.of(context).pop();
                        },
                     )
                    ],
               ) );
       });
  }
  _imageFromGallery()async{
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
         _viewModel.setProfilePicture(File(image?.path?? ""));

  }
  _imageFromCamera()async{
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
         _viewModel.setProfilePicture(File(image?.path?? ""));
  }


  Widget _imagePickedByUser(File? image)
  {
     if(image != null && image.path.isNotEmpty)
       {
        return Image.file(image);
       }
     else
       {
         return Container();
       }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
