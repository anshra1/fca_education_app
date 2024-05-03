import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:fca_education_app/src/auth/datasources/models/user_model.dart';
import 'package:fca_education_app/src/course/data/model/course_model.dart';
import 'package:fca_education_app/src/course/features/exams/data/datasources/exam_remote_data_src.dart';
import 'package:fca_education_app/src/course/features/exams/data/model/exam_model.dart';
import 'package:fca_education_app/src/course/features/exams/data/model/exam_question_model.dart';
import 'package:fca_education_app/src/course/features/exams/data/model/user_choice_model.dart';
import 'package:fca_education_app/src/course/features/exams/data/model/user_exam_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  late ExamRemoteDataSrc remoteDataSrc;
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

    remoteDataSrc = ExamRemoteDataSrcImpl(
      firestore: firestore,
      auth: auth,
    );
  });

  group(
    'upload exam',
    () {
      test(
        'should upload the give [Exam] to the firestore and seprate the '
        '[Exam] and the [Exam.questions]',
        () async {
          // arange
          final exam = const ExamModel.empty().copyWith(
            questions: [const ExamQuestionModel.empty()],
          );

          await firestore.collection('courses').doc(exam.courseId).set(
                CourseModel.empty()
                    .copyWith()
                    .copyWith(id: exam.courseId)
                    .toMap(),
              );

          // act
          await remoteDataSrc.uploadExam(exam);

          // assert
          final examsDocs = await firestore
              .collection('courses')
              .doc(exam.courseId)
              .collection('exams')
              .get();

          expect(examsDocs.docs, isNotEmpty);

          final examModel = ExamModel.fromMap(examsDocs.docs.first.data());
          expect(examModel.courseId, exam.courseId);

          final questionDocs = await firestore
              .collection('courses')
              .doc(examModel.courseId)
              .collection('exams')
              .doc(examModel.id)
              .collection('questions')
              .get();

          expect(questionDocs.docs, isNotEmpty);
          final questionModel =
              ExamQuestionModel.fromMap(questionDocs.docs.first.data());

          expect(questionModel.courseId, examModel.courseId);
          expect(questionModel.examId, examModel.id);
        },
      );
    },
  );

  group(
    'getExamQuestions',
    () {
      test('should return the questions of the given exam', () async {
        // arrange
        final exam = const ExamModel.empty().copyWith(
          questions: [
            const ExamQuestionModel.empty(),
          ],
        );

        await firestore
            .collection('courses')
            .doc(exam.courseId)
            .set(CourseModel.empty().copyWith(id: exam.courseId).toMap());

        await remoteDataSrc.uploadExam(exam);

        final examCollection = await firestore
            .collection('courses')
            .doc(exam.courseId)
            .collection('exams')
            .get();

        // act
        final examModel = ExamModel.fromMap(examCollection.docs.first.data());
        final result = await remoteDataSrc.getExamQuestions(examModel);

        // assert
        expect(result, isA<List<ExamQuestionModel>>());

        expect(result, hasLength(1));
        expect(result.first.courseId, exam.courseId);
      });
    },
  );

  group(
    'getExams',
    () {
      test(
        'should return the exams of the given course',
        () async {
          final exam = const ExamModel.empty().copyWith(
            questions: [
              const ExamQuestionModel.empty(),
            ],
          );

          await firestore
              .collection('courses')
              .doc(exam.courseId)
              .set(CourseModel.empty().copyWith(id: exam.courseId).toMap());

          await remoteDataSrc.uploadExam(exam);

          final result = await remoteDataSrc.getExams(exam.courseId);

          expect(result, isA<List<ExamModel>>());
          expect(result, hasLength(1));
          expect(result.first.courseId, exam.courseId);
        },
      );
    },
  );

  group('updateExam', () {
    test('should update the given exam', () async {
      // arrange
      final exam = const ExamModel.empty().copyWith(
        questions: [const ExamQuestionModel.empty()],
      );
      await firestore.collection('courses').doc(exam.courseId).set(
            //  ExamModel.empty().copyWith(id: exam.courseId).toMap(),
            CourseModel.empty().copyWith(id: exam.courseId).toMap(),
          );

      await remoteDataSrc.uploadExam(exam);
      // No need to assert the uploadExam method because it's already tested
      // act
      final examsCollection = await firestore
          .collection('courses')
          .doc(exam.courseId)
          .collection('exams')
          .get();

      final examModel = ExamModel.fromMap(examsCollection.docs.first.data());
      await remoteDataSrc.updateExam(examModel.copyWith(timeLimit: 100));
      // assert
      final updatedExam = await firestore
          .collection('courses')
          .doc(exam.courseId)
          .collection('exams')
          .doc(examModel.id)
          .get();

      expect(updatedExam.data(), isNotEmpty);
      final updatedExamModel = ExamModel.fromMap(updatedExam.data()!);
      expect(updatedExamModel.courseId, exam.courseId);
      expect(updatedExamModel.timeLimit, 100);
    });
  });

  group(
    'submit exam',
    () {
      test(
        'should sumit the exam',
        () async {
          // arrange
          final userExam = UserExamModel.empty().copyWith(
            totalQuestions: 2,
            answers: [const UserChoiceModel.empty()],
          );

          await firestore.collection('users').doc(auth.currentUser!.uid).set(
                const LocalUserModel.empty()
                    .copyWith(uid: auth.currentUser!.uid, points: 1)
                    .toMap(),
              );

          // act
          await remoteDataSrc.submitExam(userExam);

          // assert
          final summittedExam = await firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .collection('courses')
              .doc(userExam.courseId)
              .collection('exams')
              .doc(userExam.examId)
              .get();

          expect(summittedExam.data(), isNotEmpty);

          final summitedExamModel =
              UserExamModel.fromMap(summittedExam.data()!);

          expect(summitedExamModel.courseId, userExam.courseId);

          final userDoc = await firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .get();

          expect(userDoc.data(), isNotEmpty);

          final userModel = LocalUserModel.fromMap(map: userDoc.data()!);
          expect(userModel.points, 51);
          expect(userModel.enrolledCourses, contains(userExam.courseId));
        },
      );
    },
  );

  group(
    'getUserCourseExams',
    () {
      test(
        'should return the exams of the given course',
        () async {
          final exam = UserExamModel.empty();

          await firestore.collection('users').doc(auth.currentUser!.uid).set(
                const LocalUserModel.empty()
                    .copyWith(uid: auth.currentUser!.uid, points: 1)
                    .toMap(),
              );

          await remoteDataSrc.submitExam(exam);

          // act
          final result = await remoteDataSrc.getUserCourseExams(exam.courseId);

          // assert
          expect(result, isA<List<UserExamModel>>());
          expect(result, hasLength(1));
          expect(result.first.courseId, exam.courseId);
        },
      );
    },
  );

  group(
    'getUserExams',
    () {
      test(
        'should return the exams of the current user',
        () async {
          final exam = UserExamModel.empty();
          await firestore.collection('users').doc(auth.currentUser!.uid).set(
                const LocalUserModel.empty()
                    .copyWith(uid: auth.currentUser!.uid, points: 1)
                    .toMap(),
              );

          await firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .collection('courses')
              .doc(exam.courseId)
              .set(
                CourseModel.empty().copyWith(id: exam.courseId).toMap(),
              );

          await remoteDataSrc.submitExam(exam);

          // act
          final result = await remoteDataSrc.getUserExams();

          expect(result, isA<List<UserExamModel>>());
          expect(result, hasLength(1));
          expect(result.first.courseId, exam.courseId);
        },
      );
    },
  );
}
