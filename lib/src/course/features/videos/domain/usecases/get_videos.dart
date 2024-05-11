import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/videos/domain/entity/video.dart';
import 'package:fca_education_app/src/course/features/videos/domain/repo/video_repo.dart';

class GetVideos extends UseCaseWithParams<List<Video>, String> {
  GetVideos({required VideoRepo repo}) : _repo = repo;

  final VideoRepo _repo;

  @override
  ResultFuture<List<Video>> call({required String params}) {
    return _repo.getVideos(params);
  }
}
