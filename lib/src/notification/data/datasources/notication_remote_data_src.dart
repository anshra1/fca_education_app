import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fca_education_app/core/errors/exception.dart';
import 'package:fca_education_app/core/utils/datasourse_utils.dart';
import 'package:fca_education_app/src/notification/data/model/notification_model.dart';
import 'package:fca_education_app/src/notification/domain/entity/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class NotificationRemoteDataSrc {
  const NotificationRemoteDataSrc();

  Future<void> markAsRead(String notificationId);

  Future<void> clearAll();

  Future<void> clear(String notificationId);

  Future<void> sendNotification(Notification notification);

  Stream<List<NotificationModel>> getNotifications();
}

class NotificationRemoteDataSrcImpl implements NotificationRemoteDataSrc {
  NotificationRemoteDataSrcImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  @override
  Future<void> clear(String notificationId) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .doc(notificationId)
          .delete();
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'unknown error occured',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      final query = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications');
      return _deleteNotificationByQuery(query);
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'unknown error occured',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Stream<List<NotificationModel>> getNotifications() {
    try {
      DataSourceUtils.authorizeUser(_auth);
      final notificationsStream = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .orderBy(
            'sentAt',
            descending: true,
          )
          .snapshots()
          .map(
            (snapshot) => snapshot.docs.map((doc) {
              return NotificationModel.fromMap(doc.data());
            }).toList(),
          );
      return notificationsStream.handleError((
        dynamic error,
        dynamic stackTrace,
      ) {
        if (error is FirebaseException) {
          throw ServerException(
            message: error.message ?? 'Unknown error occurred',
            statusCode: error.code,
          );
        }
        debugPrint(error.toString());
        debugPrint(stackTrace.toString());
        throw ServerException(message: error.toString(), statusCode: '505');
      });
    } on FirebaseException catch (e) {
      return Stream.error(
        ServerException(
          message: e.message ?? 'Unknown error occurred',
          statusCode: e.code,
        ),
      );
    } on ServerException catch (e) {
      return Stream.error(e);
    } catch (e) {
      return Stream.error(
        ServerException(message: e.toString(), statusCode: '505'),
      );
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .doc(notificationId)
          .update({'seen': true});
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'unknown error occured',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> sendNotification(Notification notification) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);

      final users = await _firestore.collection('users').get();

      if (users.docs.length > 500) {
        for (final i = 0; i < users.docs.length; i + 500) {
          final batch = _firestore.batch();
          final end = i + 500;

          final usersBatch = users.docs
              .sublist(i, end > users.docs.length ? users.docs.length : end);

          for (final user in usersBatch) {
            final newNotificationRef =
                user.reference.collection('notifications').doc();
            batch.set(
              newNotificationRef,
              (notification as NotificationModel)
                  .copyWith(id: newNotificationRef.id)
                  .toMap(),
            );
          }
          await batch.commit();
        }
      } else {
        final batch = _firestore.batch();
        for (final user in users.docs) {
          final newNotificationRef =
              user.reference.collection('notifications').doc();
          batch.set(
            newNotificationRef,
            (notification as NotificationModel)
                .copyWith(id: newNotificationRef.id)
                .toMap(),
          );
        }
        await batch.commit();
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'unknown error occured',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  Future<void> _deleteNotificationByQuery(Query query) async {
    final notification = await query.get();

    if (notification.docs.length > 500) {
      for (final i = 0; i < notification.docs.length; i + 500) {
        final batch = _firestore.batch();
        final end = i + 500;
        final notificationBatch = notification.docs.sublist(
          i,
          end > notification.docs.length ? notification.docs.length : end,
        );

        for (final notification in notificationBatch) {
          batch.delete(notification.reference);
        }
        await batch.commit();
      }
    } else {
      final batch = _firestore.batch();
      for (final notification in notification.docs) {
        batch.delete(notification.reference);
      }
      await batch.commit();
    }
  }
}
