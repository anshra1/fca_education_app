import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fca_education_app/%20core/errors/exception.dart';
import 'package:fca_education_app/%20core/utils/datasourse_utils.dart';
import 'package:fca_education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:fca_education_app/src/course/features/videos/domain/entity/video.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class VideoRemoteDataSrc {
  const VideoRemoteDataSrc();

  Future<List<VideoModel>> getVideos(String courseId);
  Future<void> addVideo(Video video);
}

class VideoRemoteDataSrcImpl implements VideoRemoteDataSrc {
  VideoRemoteDataSrcImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _auth = auth,
        _firestore = firestore,
        _storage = storage;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  @override
  Future<void> addVideo(Video video) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      final videoRef = _firestore
          .collection('courses')
          .doc(video.courseId)
          .collection('videos')
          .doc();

      var videoModel = (Video as VideoModel).copyWith(id: videoRef.id);

      if (videoModel.thumbnailIsFile) {
        final thumbnailFileRef = _storage.ref().child(
              'courses/${videoModel.courseId}/videos/${videoRef.id}/thumbnail',
            );

        await thumbnailFileRef.putFile(File(videoModel.thumbnail!)).then(
          (value) async {
            final url = await value.ref.getDownloadURL();
            videoModel = videoModel.copyWith(thumbnail: url);
          },
        );
      }

      await videoRef.set(videoModel.toMap());
      await _firestore
          .collection('courses')
          .doc(video.courseId)
          .update({'numberOfVideos': FieldValue.increment(1)});
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<VideoModel>> getVideos(String courseId) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);

      final videos = await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('videos')
          .get();

      return videos.docs.map((doc) => VideoModel.fromMap(doc.data())).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }
}
