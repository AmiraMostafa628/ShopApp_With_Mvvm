import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';


@JsonSerializable()
class BaseResponse{
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse{
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotification")
  int? numOfNotification;

  CustomerResponse(this.id,this.name,this.numOfNotification);

  //from json
  factory CustomerResponse.fromJson(Map<String,dynamic> json)
  => _$CustomerResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson()=> _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse{
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;

  ContactsResponse(this.phone,this.email,this.link);

  //from json
  factory ContactsResponse.fromJson(Map<String,dynamic> json)
  => _$ContactsResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson()=> _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer,this.contacts);

  //from json
  factory AuthenticationResponse.fromJson(Map<String,dynamic> json)
     => _$AuthenticationResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson()=> _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse{
  @JsonKey(name: "support")
  String? support;
  ForgetPasswordResponse(this.support);

  factory ForgetPasswordResponse.fromJson(Map<String,dynamic> json)
  => _$ForgetPasswordResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson()=> _$ForgetPasswordResponseToJson(this);
}

@JsonSerializable()
class ServicesResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;

  ServicesResponse(this.id,this.title,this.image);

  //from json
  factory ServicesResponse.fromJson(Map<String,dynamic> json)
  => _$ServicesResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson()=> _$ServicesResponseToJson(this);
}

@JsonSerializable()
class BannersResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "link")
  String? link;

  BannersResponse(this.id,this.title,this.image,this.link);

  //from json
  factory BannersResponse.fromJson(Map<String,dynamic> json)
  => _$BannersResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson()=> _$BannersResponseToJson(this);
}

@JsonSerializable()
class StoresResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;

  StoresResponse(this.id,this.title,this.image);

  //from json
  factory StoresResponse.fromJson(Map<String,dynamic> json)
  => _$StoresResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson()=> _$StoresResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse{
  @JsonKey(name: "services")
  List<ServicesResponse>? services;

  @JsonKey(name: "banners")
  List<BannersResponse>? banners;

  @JsonKey(name: "stores")
  List<StoresResponse>? stores;

  HomeDataResponse(this.services,this.banners,this.stores);

  //from json
  factory HomeDataResponse.fromJson(Map<String,dynamic> json)
  => _$HomeDataResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson()=> _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name: "data")
  HomeDataResponse? data;


  HomeResponse(this.data);

  //from json
  factory HomeResponse.fromJson(Map<String,dynamic> json)
  => _$HomeResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson()=> _$HomeResponseToJson(this);
}

@JsonSerializable()
class StoreDetailsResponse extends BaseResponse{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'details')
  String? details;
  @JsonKey(name: 'services')
  String? services;
  @JsonKey(name: 'about')
  String? about;

  StoreDetailsResponse(this.id, this.title, this.image,this.details, this.services, this.about);

  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDetailsResponseToJson(this);
}


