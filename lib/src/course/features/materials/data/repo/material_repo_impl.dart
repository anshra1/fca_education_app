import 'package:dartz/dartz.dart';
import 'package:fca_education_app/%20core/errors/exception.dart';
import 'package:fca_education_app/%20core/errors/failure.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/materials/data/datasources/material_remote_data_src.dart';
import 'package:fca_education_app/src/course/features/materials/domain/entity/resourse.dart';
import 'package:fca_education_app/src/course/features/materials/domain/repo/material_repo.dart';

class MaterialRepoImpl implements MaterialRepo {
  const MaterialRepoImpl(this._remoteDataSource);

  final MaterialRemoteDataSrc _remoteDataSource;

  @override
  ResultFuture<List<Resource>> getMaterials(String courseId) async {
    try {
      final result = await _remoteDataSource.getMaterials(courseId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(serverException: e));
    }
  }

  @override
  ResultFuture<void> addMaterial(Resource material) async {
    try {
      await _remoteDataSource.addMaterial(material);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(serverException: e));
    }
  }
}
