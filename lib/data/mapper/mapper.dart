import 'package:clean_architecture/app/constants.dart';
import 'package:clean_architecture/domain/model/models.dart';
import 'package:clean_architecture/app/extensions.dart';
import '../response/responses.dart';

extension CustomerResponseMapper on CustomerResponse?{
 Customer toDomain()
 {
   return Customer(
       this?.id.orEmpty()?? Constants.empty,
       this?.name.orEmpty()?? Constants.empty,
       this?.numOfNotification.orZero() ?? Constants.zero);
 }
}

extension ContactsResponseMapper on ContactsResponse?{
  Contacts toDomain()
  {
    return Contacts(
        this?.email.orEmpty()?? Constants.empty,
        this?.phone.orEmpty()?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse?{
   Authentication toDomain()
  {
    return Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
  }
}

extension ForgetPasswordResponseMapper on ForgetPasswordResponse?{
  String toDomain()
  {
    return this?.support.orEmpty() ?? Constants.empty;
  }
}

extension ServicesResponseMapper on ServicesResponse?{
  Services toDomain()
  {
    return Services(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty()?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension BannersResponseMapper on BannersResponse?{
  BannerAdv toDomain()
  {
    return BannerAdv(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty()?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension StoresResponseMapper on StoresResponse?{
  Stores toDomain()
  {
    return Stores(
        (this?.id.orZero() ?? Constants.zero),
        this?.title.orEmpty()?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension HomeResponseMapper on HomeResponse?{
  HomeObject toDomain()
  {
    List <Services> services =
    (this?.data?.services?.map((servicesResponse) => servicesResponse.toDomain())??
    const Iterable.empty()).cast<Services>().toList();

    List <BannerAdv> banners =
    (this?.data?.banners?.map((bannersResponse) => bannersResponse.toDomain())??
        const Iterable.empty()).cast<BannerAdv>().toList();

    List <Stores> stores =
    (this?.data?.stores?.map((storesResponse) => storesResponse.toDomain())??
        const Iterable.empty()).cast<Stores>().toList();

    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse?{
  StoresDetailsObject toDomain()
  {
   return StoresDetailsObject(
       this?.id?.orZero() ?? Constants.zero,
       this?.title?.orEmpty()?? Constants.empty,
       this?.image?.orEmpty() ?? Constants.empty,
       this?.details?.orEmpty() ?? Constants.empty,
       this?.services?.orEmpty() ?? Constants.empty,
       this?.about?.orEmpty() ?? Constants.empty);
  }
}