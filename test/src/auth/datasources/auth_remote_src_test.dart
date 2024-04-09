// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:fca_education_app/%20core/enum/user_data.dart';
import 'package:fca_education_app/%20core/errors/exception.dart';
import 'package:fca_education_app/%20core/utils/constants.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/auth/datasources/datasources/auth_remote_src.dart';
import 'package:fca_education_app/src/auth/datasources/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {
  String _uid = 'Test uid';

  @override
  String get uid => _uid;

  set uid(String value) {
    if (uid != value) _uid = value;
  }
}

class MockAuthCredential extends Mock implements AuthCredential {}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential([User? user]) : _user = user;

  User? _user;

  @override
  User? get user => _user;

  set user(User? value) {
    if (_user != value) _user = value;
  }
}

void main() {
  late FakeFirebaseFirestore cloudStoreClient;
  late MockFirebaseAuth authClient;
  late MockFirebaseStorage dbClient;
  late AuthRemotedataSources dataSources;
  late MockUser mockUser;
  late UserCredential userCredential;
  late DocumentReference<DataMap> documentReference;

  const tUser = LocalUserModel.empty();

  setUpAll(
    () async {
      cloudStoreClient = FakeFirebaseFirestore();

      documentReference = cloudStoreClient.collection('users').doc();
      await documentReference
          .set(tUser.copyWith(uid: documentReference.id).toMap());
      authClient = MockFirebaseAuth();
      mockUser = MockUser()..uid = documentReference.id;

      userCredential = MockUserCredential(mockUser);

      when(() => authClient.currentUser).thenReturn(mockUser);

      dbClient = MockFirebaseStorage();

      dataSources = AuthRemotedataSourcesImpl(
        firestoreClient: cloudStoreClient,
        authClient: authClient,
        dbClient: dbClient,
      );
    },
  );

  const tPassword = 'Test password';
  const tFullName = 'Test Full Name';
  const tEmail = 'test@testmail.com';

  final tFirebaseException = FirebaseAuthException(
    code: 'users-not-found',
    message: 'there is no recored for this user',
  );

  group(
    'forgot password',
    () {
      test(
        'should complte sucessfully when no exception',
        () {
          when(
            () => authClient.sendPasswordResetEmail(email: tEmail),
          ).thenAnswer((_) async => Future.value());

          final call = dataSources.forgotPassword(email: tEmail);

          expect(call, completes);

          verify(() => authClient.sendPasswordResetEmail(email: tEmail))
              .called(1);
          verifyNoMoreInteractions(authClient);
        },
      );

      test(
        'should complte sucessfully when no exception',
        () async {
          when(
            () => authClient.sendPasswordResetEmail(email: any(named: 'email')),
          ).thenThrow(tFirebaseException);

          final call = dataSources.forgotPassword;

          expect(
            () => call(email: tEmail),
            throwsA(isA<ServerException>()),
          );

          verify(() => authClient.sendPasswordResetEmail(email: tEmail))
              .called(1);
          verifyNoMoreInteractions(authClient);
        },
      );
    },
  );

  group(
    'sign in',
    () {
      test(
        'should return local user when no exception thrown',
        () async {
          when(
            () => authClient.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((_) async => userCredential);

          final result = await dataSources.signIn(
            email: tEmail,
            password: tPassword,
          );

          expect(result.uid, userCredential.user!.uid);
          //  expect(result.uid, tUser.uid);

          verify(
            () => authClient.signInWithEmailAndPassword(
              email: tEmail,
              password: tPassword,
            ),
          ).called(1);

          verifyNoMoreInteractions(authClient);
        },
      );

      test(
        'should throw server exception when firebaseException thrown',
        () async {
          when(
            () => authClient.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(tFirebaseException);

          final call = dataSources.signIn;
          expect(
            () => call(
              email: tEmail,
              password: tPassword,
            ),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => authClient.signInWithEmailAndPassword(
              email: tEmail,
              password: tPassword,
            ),
          ).called(1);

          verifyNoMoreInteractions(authClient);
        },
      );

      test(
        'should throw exception when user is not found after sign in',
        () {
          final cred = MockUserCredential();
          when(
            () => authClient.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((_) async => cred);

          final call = dataSources.signIn;

          expect(
            () => call(email: tEmail, password: tPassword),
            throwsA(isA<ServerException>()),
          );
        },
      );
    },
  );

  group(
    'sign up',
    () {
      test(
        'should complte sucessfully when no exception',
        () async {
          when(
            () => authClient.createUserWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((invocation) async => userCredential);

          when(() => userCredential.user!.updateDisplayName(any()))
              .thenAnswer((_) async => Future.value());

          when(() => userCredential.user!.updatePhotoURL(any()))
              .thenAnswer((invocation) => Future.value());

          final call = dataSources.signUp(
            email: tEmail,
            fullName: tFullName,
            password: tPassword,
          );

          expect(call, completes);

          verify(
            () => authClient.createUserWithEmailAndPassword(
              email: tEmail,
              password: tPassword,
            ),
          ).called(1);

          await untilCalled(
            () => userCredential.user?.updateDisplayName(any()),
          );
          await untilCalled(
            () => userCredential.user?.updatePhotoURL(any()),
          );

          verify(() => userCredential.user?.updateDisplayName(tFullName))
              .called(1);

          verify(() => userCredential.user?.updatePhotoURL(kDefaultAvtar))
              .called(1);

          verifyNoMoreInteractions(authClient);
        },
      );

      test(
        'should throw server exception when firebaseException thrown',
        () async {
          when(
            () => authClient.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(tFirebaseException);

          final call = dataSources.signIn;
          expect(
            () => call(
              email: tEmail,
              password: tPassword,
            ),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => authClient.signInWithEmailAndPassword(
              email: tEmail,
              password: tPassword,
            ),
          ).called(1);

          verifyNoMoreInteractions(authClient);
        },
      );
    },
  );

  group(
    'update user',
    () {
      setUp(
        () {
          registerFallbackValue(MockAuthCredential());
        },
      );
      test(
        'update the disply name',
        () async {
          when(() => mockUser.updateDisplayName(any()))
              .thenAnswer((_) async => Future.value());

          await dataSources.updateUser(
            action: UpdateUserAction.displyName,
            userData: tFullName,
          );

          verify(() => mockUser.updateDisplayName(tFullName)).called(1);

          verifyNever(() => mockUser.updatePhotoURL(any()));
          verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
          verifyNever(() => mockUser.updatePassword(any()));

          final userData = await cloudStoreClient
              .collection('users')
              .doc(mockUser.uid)
              .get();

          expect(userData.data()!['fullName'], tFullName);
        },
      );

      test(
        'should update user bio sucessfully',
        () async {
          const newBio = 'new Bio';
          await dataSources.updateUser(
            action: UpdateUserAction.bio,
            userData: newBio,
          );

          final user = await cloudStoreClient
              .collection('users')
              .doc(documentReference.id)
              .get();

          expect(user.data()!['bio'], newBio);

          verifyNever(() => mockUser.updatePhotoURL(any()));
          verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
          verifyNever(() => mockUser.updatePassword(any()));
        },
      );

      test(
        'should update user password sucessfully when no exception',
        () async {
          when(() => mockUser.updatePassword(any()))
              .thenAnswer((_) async => Future.value());

          when(() => mockUser.reauthenticateWithCredential(any()))
              .thenAnswer((_) async => userCredential);

          when(() => mockUser.email).thenReturn(tEmail);

          await dataSources.updateUser(
            action: UpdateUserAction.password,
            userData: jsonEncode({
              'oldPassword': 'oldPassword',
              'newPassword': tPassword,
            }),
          );

          verify(() => mockUser.updatePassword(tPassword)).called(1);
          verifyNever(() => mockUser.updatePhotoURL(any()));
          verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
          verifyNever(() => mockUser.updateDisplayName(any()));

          final user = await cloudStoreClient
              .collection('users')
              .doc(documentReference.id)
              .get();

          expect(user.data()!['password'], null);
        },
      );

      test(
        'update the profile pic',
        () async {
          final newProfilePic = File('assets/images/avatar.png');

          when(() => mockUser.updatePhotoURL(any()))
              .thenAnswer((_) async => Future.value());

          await dataSources.updateUser(
            action: UpdateUserAction.profilePic,
            userData: newProfilePic,
          );

          //  verify(() => mockUser.updatePhotoURL(any()))
          //      .called(1);

          verifyNever(() => mockUser.updateDisplayName(any()));
          verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
          verifyNever(() => mockUser.updatePassword(any()));

          expect(dbClient.storedFilesMap.isNotEmpty, isTrue);
        },
      );
    },
  );

  /*  test(
    'sign up',
    () async {
      await dataSources.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tEmail,
      );

      expect(authClient.currentUser, isNotNull);
      expect(authClient.currentUser!.displayName, tFullName);

      final user = await cloudStoreClient
          .collection('users')
          .doc(authClient.currentUser!.uid)
          .get();

      expect(user.exists, isTrue);
    },
  );

  test(
    'sign in',
    () async {
      await dataSources.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tEmail,
      );
      await authClient.signOut();

      await dataSources.signIn(
        email: tEmail,
        password: tPassword,
      );

      expect(authClient.currentUser, isNotNull);
      expect(authClient.currentUser!.email, tEmail);
    },
  );

  group( 
    'update user',
    () {
      test(
        'update name',
        () async {
          await dataSources.signUp(
            email: tEmail,
            fullName: tFullName,
            password: tPassword,
          );
          await dataSources.updateUser(
            action: UpdateUserAction.displyName,
            userData: 'new Name',
          );
          expect(authClient.currentUser!.displayName, 'new Name');
        },
      );
      test(
        'update email',
        () async {
          await dataSources.signUp(
            email: tEmail,
            fullName: tFullName,
            password: tPassword,
          );
          await dataSources.updateUser(
            action: UpdateUserAction.email,
            userData: 'new@email.com',
          );
          expect(authClient.currentUser!.displayName, 'new@email.com');
        },
      );
    },
  );*/
}
