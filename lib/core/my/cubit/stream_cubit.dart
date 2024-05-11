// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'stream_state.dart';

// class StreamCubit extends Cubit<StreamState> {
//   StreamCubit() : super(StreamInitial());

//   void testStream() {
//     emit(StreamLoading());

//     // listenStream(
//     //   Stream.periodic(const Duration(seconds: 1), (count) => count),
//     //   this,
//     //   initialValue: 12,
//     //   onData: (data) {
//     //     emit(StreamLoaded(data));
//     //   },
//     // );
//   }

//     void startTimer() {
//     const duration = Duration(seconds: 1);
//     var count = 0;
//     Timer.periodic(duration, (timer) {
//       count++;

//       emit(UpdateTimerValue(count));
//     });
//   }

//   void streamed() {
//     emit(StreamLoading());
//     var count = 1;
//     Timer.periodic(const Duration(seconds: 1), (timer) {
//       count++;
//       emit(StreamLoaded(count));
//     });
//   }

//   void getStream() {
//     emit(StreamLoading());
//     StreamSubscription<int>? subscription;

//     subscription =
//         Stream.periodic(const Duration(seconds: 1), (count) => count).listen(
//       (result) {
//         emit(StreamLoaded(result));
//       },
//       onDone: () {
//         subscription?.cancel();
//       },
//       onError: (Object error) {
//         emit(const StreamError('Stream Error'));
//         subscription?.cancel();
//       },
//     );
//   }
// }

// StreamSubscription<T> listenStream<T>(
//   Stream<T> stream,
//   Cubit bloc, {
//   bool emitInitialValue = false,
//   T? initialValue,
//   void Function(T)? onData,
//   void Function()? onDone,
//   void Function(Object, StackTrace)? onError,
//   bool cancelOnError = true,
// }) {
//   final controller = StreamController<T>();
//   StreamSubscription<T>? subscription = stream.listen(
//     (data) {
//       controller.add(data);
//       onData?.call(data);
//     },
//     onError: (Object e, StackTrace st) {
//       controller.addError(e, st);
//       if (cancelOnError) {
//       } else {
//         onError?.call(e, st);
//       }
//     },
//     onDone: () {
//       controller.close();
//       onDone?.call();
//     },
//     cancelOnError: cancelOnError,
//   );

//   if (emitInitialValue && initialValue != null) {
//     controller.add(initialValue);
//   }

//   controller.stream.listen((data) => bloc.add(data));
//   return subscription;
// }
