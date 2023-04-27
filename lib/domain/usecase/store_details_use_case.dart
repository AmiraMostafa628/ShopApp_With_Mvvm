import 'package:clean_architecture/data/network/failure.dart';
import 'package:clean_architecture/domain/model/models.dart';
import 'package:clean_architecture/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'base_use_case.dart';

class StoreDetailsUseCase implements BaseUseCase<void,StoresDetailsObject>
{
  final Repository repository;
  StoreDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, StoresDetailsObject>> execute(void input){
    return repository.getStoresDetailsData();
  }

}
