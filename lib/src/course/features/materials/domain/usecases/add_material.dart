import 'package:fca_education_app/%20core/usecases/usecases.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/materials/domain/entity/resourse.dart';
import 'package:fca_education_app/src/course/features/materials/domain/repo/material_repo.dart';

class AddMaterial extends UseCaseWithParams<void, Resource> {
  const AddMaterial(this._repo);

  final MaterialRepo _repo;

  @override
  ResultFuture<void> call({required Resource params}) =>
      _repo.addMaterial(params);
}
