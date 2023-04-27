import 'package:clean_architecture/data/network/failure.dart';
import 'package:clean_architecture/data/network/requests.dart';
import 'package:clean_architecture/domain/model/models.dart';
import 'package:clean_architecture/domain/repository/repository.dart';
import 'package:clean_architecture/domain/usecase/base_use_case.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput,Authentication>
{
  final Repository repository;
  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) {
    return repository.register(RegisterRequest(input.userName,
        input.countryMobileCode, input.mobileNumber,
        input.email, input.password, input.profilePicture));
  }

}

class RegisterUseCaseInput {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput(
      this.userName,this.countryMobileCode,
      this.mobileNumber,this.email,
      this.password,this.profilePicture);
}