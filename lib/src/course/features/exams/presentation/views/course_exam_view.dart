import 'package:fca_education_app/core/common/views/loading_view.dart';
import 'package:fca_education_app/core/common/widgets/nested_back_button.dart';
import 'package:fca_education_app/core/common/widgets/not_found_text.dart';
import 'package:fca_education_app/core/extensions/context_extension.dart';
import 'package:fca_education_app/core/extensions/int_extension.dart';
import 'package:fca_education_app/core/utils/core_utils.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:fca_education_app/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:fca_education_app/src/course/features/exams/presentation/views/exams_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CourseExamView extends StatefulWidget {
  const CourseExamView(this.course, {super.key});

  static const routeName = '/course-exam-view';
  final Course course;

  @override
  State<CourseExamView> createState() => _CourseExamViewState();
}

class _CourseExamViewState extends State<CourseExamView> {
  void getExams() {
    context.read<ExamCubit>().getExams(widget.course.id);
  }

  @override
  void initState() {
    super.initState();
    getExams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${widget.course.title} Exams'),
        leading: const NestedBackButton(),
      ),
      body: BlocConsumer<ExamCubit, ExamState>(
        listener: (context, state) {
          if (state is ExamError) {
            CoreUtils.showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is GettingExams) {
            return const Loadingview();
          } else if ((state is ExamsLoaded && state.exams.isEmpty) ||
              state is ExamError) {
            return NotFoundText(
              text: 'No Exams found for ${widget.course.title}',
            );
          } else if (state is ExamsLoaded) {
            return SafeArea(
              child: ListView.builder(
                itemCount: state.exams.length,
                itemBuilder: (context, index) {
                  final exam = state.exams[index];
                  return Stack(
                    children: [
                      Card(
                        margin: const EdgeInsets.all(4).copyWith(bottom: 30),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                exam.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(exam.description),
                              const Gap(10),
                              Text(
                                exam.timeLimit.displayDuration,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.width * .2,
                            vertical: 10,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                ExamDetailsView.routeName,
                                arguments: exam,
                              );
                            },
                            child: const Text('Take Exam'),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
