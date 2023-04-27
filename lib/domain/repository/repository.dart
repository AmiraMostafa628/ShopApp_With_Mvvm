import 'package:clean_architecture/data/network/failure.dart';
import 'package:clean_architecture/data/network/requests.dart';
import 'package:clean_architecture/domain/model/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository{
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure,String>> forgetPassword(String email);
  Future<Either<Failure,Authentication>> register(RegisterRequest registerRequest);
  Future<Either<Failure,HomeObject>> getHomeData();
  Future<Either<Failure,StoresDetailsObject>> getStoresDetailsData();
}