
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:gap/gap.dart';

// void main() {
//   runApp(const HomePage());
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Quiz App'),
//           ),
//           body: Quiz(
//             exam: Exam(
//               examQuestion: 'Color of Apple is ',
//               questionOption: ['Green', 'Red', 'Blue', 'Black'],
//               answer: 'Red',
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Quiz extends HookWidget {
//   const Quiz({
//     required this.exam,
//     super.key,
//   });

//   final Exam exam;

//   @override
//   Widget build(BuildContext context) {
//     final boxGlobal = useState(false);
//     final box0 = useState(false);
//     final box1 = useState(false);
//     final box2 = useState(false);
//     final box3 = useState(false);

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(exam.examQuestion),
//         Column(
//           children: [
//             OptionTile(
//               boxGlobal: boxGlobal,
//               localValue: box0,
//               questionOptionText: exam.questionOption.elementAt(0),
//               answer: exam.answer,
//             ),
//             const Gap(10),
//             OptionTile(
//               boxGlobal: boxGlobal,
//               localValue: box1,
//               questionOptionText: exam.questionOption.elementAt(1),
//               answer: exam.answer,
//             ),
//             const Gap(10),
//             OptionTile(
//               boxGlobal: boxGlobal,
//               localValue: box2,
//               questionOptionText: exam.questionOption.elementAt(2),
//               answer: exam.answer,
//             ),
//             const Gap(10),
//             OptionTile(
//               boxGlobal: boxGlobal,
//               localValue: box3,
//               questionOptionText: exam.questionOption.elementAt(3),
//               answer: exam.answer,
//             ),
//             const Gap(6),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class OptionTile extends StatelessWidget {
//   const OptionTile({
//     required this.boxGlobal,
//     required this.localValue,
//     required this.answer,
//     required this.questionOptionText,
//     super.key,
//   });

//   final ValueNotifier<bool> boxGlobal;
//   final ValueNotifier<bool> localValue;
//   final String questionOptionText;
//   final String answer;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: GestureDetector(
//         onTap: () {
//           boxGlobal.value = true;
//           localValue.value = true;
//         },
//         child: Container(
//           width: double.infinity,
//           height: 45,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: boxGlobal.value == true
//                 ? questionOptionText == answer
//                     ? Colors.green
//                     : localValue.value
//                         ? Colors.red
//                         : Colors.grey
//                 : Colors.grey,
//           ),
//           child: Center(
//             child: Text(
//               questionOptionText,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Exam {
//   Exam({
//     required this.examQuestion,
//     required this.questionOption,
//     required this.answer,
//     this.userAnswer,
//   });

//   final String examQuestion;
//   final List<String> questionOption;
//   final String answer;
//   final String? userAnswer;
// }
