import 'package:fca_education_app/%20core/utils/typedefs.dart';

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();
  ResultFuture<Type> call({required Params params});
}

abstract class UseCaseWithoutParam<Type> {
  const UseCaseWithoutParam();
  ResultFuture<Type> call();
}

abstract class StreamUseCaseWithParams<Type, Params> {
  const StreamUseCaseWithParams();
  ResultStream<Type> call({required Params params});
}

abstract class StreamUseCaseWithoutParam<Type> {
  const StreamUseCaseWithoutParam();
  ResultStream<Type> call();
}
