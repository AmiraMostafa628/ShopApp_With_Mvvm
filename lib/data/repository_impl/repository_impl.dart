import 'package:clean_architecture/data/data_source/local_data_source.dart';
import 'package:clean_architecture/data/mapper/mapper.dart';
import 'package:clean_architecture/data/network/error_handler.dart';
import 'package:clean_architecture/data/network/failure.dart';
import 'package:clean_architecture/data/network/network_info.dart';
import 'package:clean_architecture/data/network/requests.dart';
import 'package:clean_architecture/domain/model/models.dart';
import 'package:clean_architecture/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import '../data_source/remote_data_source.dart';

class RepositoryImpl implements Repository{
 final  RemoteDataSource _remoteDataSource;
 final  LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource,this._networkInfo,this._localDataSource);

  @override
  Future<Either<Failure, Authentication>>login(
      LoginRequest loginRequest) async{
    if(await _networkInfo.isConnected)
      {
       try{
         //its connected to internet , Its safe to call API
         final response = await _remoteDataSource.login(loginRequest);
         if (response.status == ApiInternalStatus.success)
         {
           //success, return either right, return data
           DataSource.success.getFailure();
           return Right(response.toDomain());

         }
         else
         {
           // failure --error business error
           //return either left
           return Left(Failure(ApiInternalStatus.failure,response.message??
               ResponseMessage.Default ));
         }
       }
       catch (error)
       {
         return Left(ErrorHandler.handle(error).failure);
       }

      }
    else
      {
        // return internet connection error
        return Left(DataSource.noInternetConnection.getFailure());

      }


  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email)async {
    if(await _networkInfo.isConnected)
    {
      try{
        //its connected to internet , Its safe to call API
        final response = await _remoteDataSource.forgetPassword(email);
        if (response.status == ApiInternalStatus.success)
        {
          //success, return either right, return data
          DataSource.success.getFailure();
          return Right(response.toDomain());

        }
        else
        {
          // failure --error business error
          //return either left
          return Left(Failure(ApiInternalStatus.failure,response.message??
              ResponseMessage.Default ));
        }
      }
      catch (error)
      {
        return Left(ErrorHandler.handle(error).failure);
      }

    }
    else
    {
      // return internet connection error
      return Left(DataSource.noInternetConnection.getFailure());

    }

  }

 @override
 Future<Either<Failure, Authentication>>register(
    RegisterRequest registerRequest) async{
   if(await _networkInfo.isConnected)
   {
     try{
       //its connected to internet , Its safe to call API
       final response = await _remoteDataSource.register(registerRequest);
       if (response.status == ApiInternalStatus.success)
       {
         //success, return either right, return data
         DataSource.success.getFailure();
         return Right(response.toDomain());

       }
       else
       {
         // failure --error business error
         //return either left
         return Left(Failure(ApiInternalStatus.failure,response.message??
             ResponseMessage.Default ));
       }
     }
     catch (error)
     {
       return Left(ErrorHandler.handle(error).failure);
     }

   }
   else
   {
     // return internet connection error
     return Left(DataSource.noInternetConnection.getFailure());

   }


 }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async{

    try{
      //get response from cache
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    }
    catch(cacheError)
    {
      // cache isn't valid get response from api
      if(await _networkInfo.isConnected)
      {
        try{
          //its connected to internet , Its safe to call API
          final response = await _remoteDataSource.getHomeData();
          if (response.status == ApiInternalStatus.success)
          {
            //success, return either right, return data
            // save data to cache
            _localDataSource.saveDataToCache(response);
            DataSource.success.getFailure();
            return Right(response.toDomain());

          }
          else
          {
            // failure --error business error
            //return either left
            return Left(Failure(ApiInternalStatus.failure,response.message??
                ResponseMessage.Default ));
          }
        }
        catch (error)
        {
          return Left(ErrorHandler.handle(error).failure);
        }

      }
      else
      {
        // return internet connection error
        return Left(DataSource.noInternetConnection.getFailure());

      }

    }
  }

  @override
  Future<Either<Failure, StoresDetailsObject>> getStoresDetailsData() async {
    try {
      final response = await _localDataSource.getStoreDetailsData();
      return Right(response.toDomain());
    }
    catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getStoresDetails();
          if (response.status == ApiInternalStatus.success) {
            _localDataSource.saveStoreDataToCache(response);
            return Right(response.toDomain());
          }
          else {
            return Left(Failure(response.status ?? ResponseCode.Default,
                response.message ?? ResponseMessage.Default));
          }
        }
        catch (error) {
          return Left(ErrorHandler
              .handle(error)
              .failure);
        }
      }
      else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

}