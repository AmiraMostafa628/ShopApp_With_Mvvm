
//onBoarding model
class SliderObject{
  String title;
  String subTile;
  String image;

  SliderObject(this.title,this.subTile,this.image);
}

class SliderViewObject{
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject,this.numOfSlides,this.currentIndex);
}

//login model

class Customer
{
  String id;
  String name;
  int numofNotification;

  Customer(this.id,this.name,this.numofNotification);
}

class Contacts
{
  String email;
  String phone;
  String link;

  Contacts(this.email,this.phone,this.link);
}

class Authentication
{
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer,this.contacts);
}

class Services
{
  int id;
  String title;
  String image;

  Services(this.id,this.title,this.image);
}

class BannerAdv
{
  int id;
  String title;
  String image;
  String link;

  BannerAdv(this.id,this.title,this.image,this.link);
}

class Stores
{
  int id;
  String title;
  String image;

  Stores(this.id,this.title,this.image);
}

class HomeData
{
  List<Services> services;
  List<BannerAdv> banners;
  List<Stores> stores;

  HomeData(this.services,this.banners,this.stores);
}

class HomeObject
{
  HomeData data;

  HomeObject(this.data);
}

class StoresDetailsObject
{
  int id;
  String title;
  String image;
  String details;
  String services;
  String about;

  StoresDetailsObject(this.id,this.title,this.image,this.details,this.services,this.about);
}