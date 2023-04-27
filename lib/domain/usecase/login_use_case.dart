import 'package:clean_architecture/data/network/failure.dart';
import 'package:clean_architecture/data/network/requests.dart';
import 'package:clean_architecture/domain/model/models.dart';
import 'package:clean_architecture/domain/repository/repository.dart';
import 'package:clean_architecture/domain/usecase/base_use_case.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>
{
  final Repository repository;
  LoginUseCase(this.repository);
  
  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) {
    return repository.login(LoginRequest(input.email,input.password));
  }
  
}

class LoginUseCaseInput {
  String email;
  String password;
  
  LoginUseCaseInput(this.email,this.password);
}