import 'package:clean_architecture/app/di.dart';
import 'package:clean_architecture/domain/model/models.dart';
import 'package:clean_architecture/presentation/common/state_renderer_impl.dart';
import 'package:clean_architecture/presentation/resoures/color_manager.dart';
import 'package:clean_architecture/presentation/resoures/string_manager.dart';
import 'package:clean_architecture/presentation/resoures/values_manager.dart';
import 'package:clean_architecture/presentation/store_details/view_model/store_details_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();
  void bind()
  {
    _viewModel.start();
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
      appBar: AppBar(
        elevation: 0.0,
        /*leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),),*/
        title: Text(AppStrings.storeDetails.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body:  Center(
        child: SingleChildScrollView(
          child: StreamBuilder<FlowStates>(
            stream: _viewModel.outputState,
            builder: (context,snapshot){
              return snapshot.data?.getScreenWidget(context, _getContentScreen(),
                      (){
                _viewModel.start();
                      })??_getContentScreen();
            },
          ),
        ),
      ),
    );
  }

  Widget _getContentScreen()
  {
    return StreamBuilder<StoresDetailsObject>(
      stream: _viewModel.storeDetailsOutputs,
      builder: (context,snapshot){
        return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getImage(snapshot.data?.image),
            _getSection(AppStrings.details.tr()),
            _getStringData(snapshot.data?.details),
            _getSection(AppStrings.services.tr()),
            _getStringData(snapshot.data?.services),
            _getSection(AppStrings.aboutStores.tr()),
            _getStringData(snapshot.data?.about),
            const SizedBox(
              height: AppSize.s28,
            )
          ],
        );
      },
    );
  }

  Widget _getImage(String? image){
    if(image != null)
      {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppPadding.p28),
          child: SizedBox(
            height: AppSize.s220,
            width: double.infinity,
            child: Card(
              elevation: AppSize.s4,
              child: Image.network(image,fit: BoxFit.cover,),
            ),
          ),
        );
      }
    else
      {
        return Container();
      }
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p12,
          left: AppPadding.p12,right: AppPadding.p12
      ),
      child: Text(title , style: Theme.of(context).textTheme.labelSmall,),
    );
  }

  Widget  _getStringData(String? text){
    if(text != null)
      {
        return Padding(
          padding: const EdgeInsets.only(top: AppPadding.p12,bottom: AppPadding.p2,
              left: AppPadding.p12,right: AppPadding.p12
          ),
          child: Text(text , style: Theme.of(context).textTheme.bodyMedium,),
        );
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
