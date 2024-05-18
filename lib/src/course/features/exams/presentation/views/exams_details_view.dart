

import 'package:fca_education_app/core/common/widgets/course_info_tile.dart';
import 'package:fca_education_app/core/common/widgets/rounded_button.dart';
import 'package:fca_education_app/core/extensions/context_extension.dart';
import 'package:fca_education_app/core/extensions/int_extension.dart';
import 'package:fca_education_app/core/res/colors.dart';
import 'package:fca_education_app/core/res/media_res.dart';
import 'package:fca_education_app/core/utils/core_utils.dart';
import 'package:fca_education_app/src/course/features/exams/data/model/exam_model.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/exam.dart';
import 'package:fca_education_app/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ExamDetailsView extends StatefulWidget {
  const ExamDetailsView(this.exam, {super.key});

  static const routeName = '/exam-details-view';

  final Exam exam;

  @override
  State<ExamDetailsView> createState() => _ExamDetailsViewState();
}

class _ExamDetailsViewState extends State<ExamDetailsView> {
  late Exam completeExam;
  void getQuestions() {
    context.read<ExamCubit>().getExamQuestions(widget.exam);
  }

  @override
  void initState() {
    super.initState();
    getQuestions();
    completeExam = widget.exam;
    print(completeExam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.exam.title),
      ),
      body: BlocConsumer<ExamCubit, ExamState>(
        listener: (context, state) {
          if (state is ExamError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is ExamQuestionsLoaded) {
            completeExam = (completeExam as ExamModel)
                .copyWith(questions: state.questions);
            print(completeExam);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Center(
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colours.physicsTileColour,
                            ),
                            child: Center(
                              child: completeExam.imageUrl != null
                                  ? Image.network(
                                      completeExam.imageUrl!,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      MediaResources.test,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        const Gap(20),
                        Text(
                          completeExam.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          completeExam.description,
                          style: const TextStyle(
                            color: Colours.neutralTextColour,
                          ),
                        ),
                        const Gap(20),
                        CourseInfoTile(
                          onPressed: () {},
                          image: Image.asset(MediaResources.examTime),
                          title: '${completeExam.timeLimit.displayDurationLong}'
                              ' for the test',
                          subTitle: 'Complete the test in '
                              '${completeExam.timeLimit.displayDurationLong}',
                        ),
                        if (state is ExamQuestionsLoaded) ...[
                          const Gap(10),
                          CourseInfoTile(
                            onPressed: (){},
                            image: Image.asset(MediaResources.examQuestions),
                            title: '${completeExam.questions?.length}'
                            ' Questions',
                            subTitle:'This test consists of '
                            '${completeExam.questions?.length} questions' ,
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (state is GettingExamQuestions)
                    const Center(child: LinearProgressIndicator())
                  else if (state is ExamQuestionsLoaded)
                    RoundedButton(
                      label: 'Start Exam',
                      onPressed: () {
                        // Navigator.pushNamed(
                        //   context,
                        //   ExamView.routeName,
                        //   arguments: completeExam,
                        // );
                      },
                    )
                  else
                    Text(
                      'No questions found for this exam',
                      style: context.theme.textTheme.titleLarge,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
