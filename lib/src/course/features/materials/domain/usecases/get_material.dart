import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/materials/domain/entity/resourse.dart';
import 'package:fca_education_app/src/course/features/materials/domain/repo/material_repo.dart';

class GetMaterials extends UseCaseWithParams<List<Resource>, String> {
  const GetMaterials(this._repo);

  final MaterialRepo _repo;

  @override
  ResultFuture<List<Resource>> call({required String params}) =>
      _repo.getMaterials(params);
}
