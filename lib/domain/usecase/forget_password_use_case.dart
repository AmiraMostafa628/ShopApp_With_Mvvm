import 'package:clean_architecture/data/network/failure.dart';
import 'package:clean_architecture/domain/repository/repository.dart';
import 'package:clean_architecture/domain/usecase/base_use_case.dart';
import 'package:dartz/dartz.dart';

class ForgetPasswordUseCase implements BaseUseCase<String,String>
{
  final Repository repository;
  ForgetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, String>> execute(String email) {
    return repository.forgetPassword(email);
  }

}