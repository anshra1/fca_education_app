import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:fca_education_app/core/errors/exception.dart';
import 'package:fca_education_app/core/errors/failure.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/notification/data/datasources/notication_remote_data_src.dart';
import 'package:fca_education_app/src/notification/data/model/notification_model.dart';
import 'package:fca_education_app/src/notification/domain/entity/notification.dart';
import 'package:fca_education_app/src/notification/domain/repo/notification_repo.dart';
import 'package:flutter/foundation.dart';

class NotificationRepoImpl implements NotificationRepo {
  const NotificationRepoImpl(this._remoteDataSrc);

  final NotificationRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<void> clear(String notificationId) async {
    try {
      await _remoteDataSrc.clear(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(serverException: e));
    }
  }

  @override
  ResultFuture<void> clearAll() async {
    try {
      await _remoteDataSrc.clearAll();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(serverException: e));
    }
  }

  @override
  ResultStream<List<Notification>> getNotifications() {
    return _remoteDataSrc.getNotifications().transform(
          StreamTransformer<List<NotificationModel>,
              Either<Failure, List<Notification>>>.fromHandlers(
            handleData: (notifications, sink) {
              sink.add(Right(notifications));
            },
            handleError: (error, stackTrace, sink) {
              debugPrint(stackTrace.toString());
             
              if (error is ServerException) {
                sink.add(
                  Left(ServerFailure.fromException(serverException: error)),
                );
              } else {
                sink.add(
                  Left(
                    ServerFailure(message: error.toString(), statusCode: 505),
                  ),
                );
              }
            },
          ),
        );
  }

  @override
  ResultFuture<void> markAsRead(String notificationId) async {
    try {
      await _remoteDataSrc.markAsRead(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(serverException: e));
    }
  }

  @override
  ResultFuture<void> sendNotification(Notification notification) async {
    try {
      await _remoteDataSrc.sendNotification(notification);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(serverException: e));
    }
  }
}
