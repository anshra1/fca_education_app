import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:fca_education_app/src/auth/datasources/models/user_model.dart';
import 'package:fca_education_app/src/notification/data/datasources/notication_remote_data_src.dart';
import 'package:fca_education_app/src/notification/data/model/notification_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  late NotificationRemoteDataSrc remoteDataSrc;
  late FakeFirebaseFirestore firestore;
  late MockFirebaseAuth auth;

  setUp(() async {
    firestore = FakeFirebaseFirestore();

    final user = MockUser(
      uid: 'uid',
      email: 'email',
      displayName: 'displayName',
    );

    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    auth = MockFirebaseAuth(mockUser: user);
    await auth.signInWithCredential(credential);

    remoteDataSrc = NotificationRemoteDataSrcImpl(
      firestore: firestore,
      auth: auth,
    );
  });

  group(
    'send notification',
    () {
      test('should complete SendNotification when call is sucessful', () async {
        const secondUID = 'second_uid';

        for (var i = 0; i < 2; i++) {
          await firestore
              .collection('users')
              .doc(i == 0 ? auth.currentUser!.uid : secondUID)
              .set(
                const LocalUserModel.empty()
                    .copyWith(
                      uid: i == 0
                          ? auth.currentUser!.displayName
                          : 'second_name',
                      fullName: i == 0
                          ? auth.currentUser!.displayName
                          : 'second_name',
                      email: i == 0 ? auth.currentUser!.email : 'second_email',
                    )
                    .toMap(),
              );
        }

        final notification = NotificationModel.empty().copyWith(
          id: '1',
          title: 'notification Title',
          body: 'test body',
        );

        // act
        await remoteDataSrc.sendNotification(notification);

        // assert
        final user1Notifications = await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('notifications')
            .get();

        final user2Notifications = await firestore
            .collection('users')
            .doc(secondUID)
            .collection('notifications')
            .get();

        expect(user1Notifications.docs, hasLength(1));
        expect(
          user1Notifications.docs.first.data()['title'],
          equals(notification.title),
        );

        expect(user2Notifications.docs, hasLength(1));
        expect(
          user2Notifications.docs.first.data()['title'],
          equals(notification.title),
        );
      });
    },
  );

  Future<DocumentReference> addNotification(
    NotificationModel notification,
  ) async {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('notifications')
        .add(notification.toMap());
  }

  group('getNotifications', () {
    test(
      'should return a [Stream<List<Notification>>] when the call is '
      'successful',
      () async {
        // Arrange
        final userId = auth.currentUser!.uid;

        await firestore
            .collection('users')
            .doc(userId)
            .set(const LocalUserModel.empty().copyWith(uid: userId).toMap());

        final expectedNotifications = [
          NotificationModel.empty(),
          NotificationModel.empty().copyWith(
            id: '1',
            sentAt: DateTime.now().add(
              const Duration(seconds: 50),
            ),
          ),
        ];

        for (final notification in expectedNotifications) {
          await addNotification(notification);
        }

        // Act
        final result = remoteDataSrc.getNotifications();

        // Assert
        expect(result, emitsInOrder([equals(expectedNotifications.reversed)]));
      },
    );

    test(
      'should return a stream of empty list when error occurs',
      () async {
        final result = remoteDataSrc.getNotifications();

        expect(result, emits(<NotificationModel>[]));
      },
    );
  });

  group(
    '',
    () {
      test(
        '',
        () async {
//when(()=> ).thenAnswer((_) async => );
        },
      );
    },
  );
}
