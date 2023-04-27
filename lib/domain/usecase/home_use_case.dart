import 'package:clean_architecture/data/network/failure.dart';
import 'package:clean_architecture/domain/model/models.dart';
import 'package:clean_architecture/domain/repository/repository.dart';
import 'package:clean_architecture/domain/usecase/base_use_case.dart';
import 'package:dartz/dartz.dart';

class HomeUseCase implements BaseUseCase<void,HomeObject>
{
  final Repository repository;
 HomeUseCase(this.repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async{
    return await repository.getHomeData();
  }

}
