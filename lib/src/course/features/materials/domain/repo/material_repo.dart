import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/materials/domain/entity/resourse.dart';

abstract class MaterialRepo {
  const MaterialRepo();

  ResultFuture<List<Resource>> getMaterials(String courseId);

  ResultFuture<void> addMaterial(Resource material);
}
