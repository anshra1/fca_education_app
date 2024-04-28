import 'package:fca_education_app/%20core/usecases/usecases.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/videos/domain/entity/video.dart';
import 'package:fca_education_app/src/course/features/videos/domain/repo/video_repo.dart';

class AddVideo extends UseCaseWithParams<void, Video> {
  AddVideo({required VideoRepo repo}) : _repo = repo;

  final VideoRepo _repo;

  @override
  ResultFuture<void> call({required Video params}) {
    return _repo.addVideo(params);
  }
}
