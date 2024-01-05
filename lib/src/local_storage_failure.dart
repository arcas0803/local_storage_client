import 'package:common_classes/common_classes.dart';

sealed class LocalStorageFailure extends Failure {
  LocalStorageFailure(
      {required super.message,
      required super.error,
      required super.stackTrace});
}

final class LocalStorageReadFailure extends LocalStorageFailure {
  LocalStorageReadFailure({
    String message = 'Error reading data from secure storage',
    required String error,
    required StackTrace stackTrace,
  }) : super(
          message: message,
          error: error,
          stackTrace: stackTrace,
        );
}

final class LocalStorageWriteFailure extends LocalStorageFailure {
  LocalStorageWriteFailure({
    String message = 'Error writing data to secure storage',
    required String error,
    required StackTrace stackTrace,
  }) : super(
          message: message,
          error: error,
          stackTrace: stackTrace,
        );
}

final class LocalStorageInitializationFailure extends LocalStorageFailure {
  LocalStorageInitializationFailure({
    String message = 'Error initializing secure storage.',
    required String error,
    required StackTrace stackTrace,
  }) : super(
          message: message,
          error: error,
          stackTrace: stackTrace,
        );
}

final class LocalStorageKeyNotFound extends LocalStorageFailure {
  LocalStorageKeyNotFound({
    required String key,
    required String error,
    required StackTrace stackTrace,
  }) : super(
          message: 'Key $key not found in secure storage',
          error: error,
          stackTrace: stackTrace,
        );
}

final class LocalStorageValueNotFound extends LocalStorageFailure {
  LocalStorageValueNotFound({
    required String value,
    required String error,
    required StackTrace stackTrace,
  }) : super(
          message: 'Value $value not found in secure storage',
          error: error,
          stackTrace: stackTrace,
        );
}
