import 'package:dartz/dartz.dart';
import 'package:fca_education_app/%20core/errors/exception.dart';
import 'package:fca_education_app/%20core/errors/failure.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/videos/data/datasourses/video_remote_data_src.dart';
import 'package:fca_education_app/src/course/features/videos/domain/entity/video.dart';
import 'package:fca_education_app/src/course/features/videos/domain/repo/video_repo.dart';

class VideoRepoImpl implements VideoRepo {
  VideoRepoImpl({
    required VideoRemoteDataSrc videoRemoteDataSrc,
  }) : _videoRemoteDataSrc = videoRemoteDataSrc;

  final VideoRemoteDataSrc _videoRemoteDataSrc;

  @override
  ResultFuture<void> addVideo(Video video) async {
    try {
      await _videoRemoteDataSrc.addVideo(video);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(serverException: e));
    }
  }

  @override
  ResultFuture<List<Video>> getVideos(String courseId) async {
    try {
      final result = await _videoRemoteDataSrc.getVideos(courseId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(serverException: e));
    }
  }
}
