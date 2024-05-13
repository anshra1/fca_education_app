import 'dart:async';

import 'package:fca_education_app/core/extensions/string_extension.dart';
import 'package:fca_education_app/core/utils/core_utils.dart';
import 'package:fca_education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:fca_education_app/src/course/features/videos/domain/entity/video.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_metadata/youtube_metadata.dart';

class VideoUtils {
  const VideoUtils._();

  static Future<Video?> getVideoFromYT(
    BuildContext context, {
    required String url,
  }) async {
    void showSnack(String message) => CoreUtils.showSnackBar(context, message);

    try {
      final metaData = await YoutubeMetaData.getData(url);
      if (metaData.thumbnailUrl == null ||
          metaData.title == null ||
          metaData.authorName == null) {
        final missingData = <String>[];
        if (metaData.thumbnailUrl == null) missingData.add('Thumbnail');
        if (metaData.title == null) missingData.add('Title');
        if (metaData.authorName == null) missingData.add('AuthorName');
        var missingDataText = missingData
            .fold(
              '',
              (previousValue, element) => '$previousValue$element,',
            )
            .trim();

        missingDataText =
            missingDataText.substring(0, missingDataText.length - 1);

        final message = 'Could not get Video data. Please try again.\n'
            'The following data is missing :$missingDataText';

        showSnack(message);
        return null;
      }
      return VideoModel.empty().copyWith(
        thumbnail: metaData.thumbnailUrl,
        videoURL: url,
        title: metaData.title,
        tutor: metaData.authorName,
      );
    } catch (e) {
      showSnack('PLEASE TRY AGAIN \n $e');
      return null;
    }
  }

  static Future<void> playVideo(BuildContext context, String videoURL) async {
    final navigator = Navigator.of(context);
    if (videoURL.isYoutubeVideo) {
      if (!await launchUrl(
        Uri.parse(videoURL),
        mode: LaunchMode.externalApplication,
      )) {
        CoreUtils.showSnackBar(
          // ignore: use_build_context_synchronously
          context,
          'Could not launch $videoURL',
        );
      }
    } else {
     // unawaited(
       // navigator.pushNamed(
      //    VideoPlayerView.routeName,
        //  arguments: videoURL,
       // ),
   //   );
    }
  }
}
