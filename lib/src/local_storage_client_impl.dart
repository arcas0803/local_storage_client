import 'dart:async';

import 'package:common_classes/common_classes.dart';
import 'package:isar/isar.dart';
import 'package:local_storage_client/src/local_storage_client.dart';
import 'package:local_storage_client/src/local_storage_failure.dart';
import 'package:logger/logger.dart';

/// [LocalStorageClientImpl] is a class that implements [LocalStorageClient]
///
/// This class is used to save, read and delete data from local storage
/// via [Isar]
///
class LocalStorageClientImpl<I, M> implements LocalStorageClient<I, M> {
  final Isar _isar;

  final Logger? _logger;

  final FutureOr<void> Function(Failure)? _telemetryOnError;

  final FutureOr<void> Function()? _telemetryOnSuccess;

  LocalStorageClientImpl({
    required Isar isar,
    Logger? logger,
    FutureOr<void> Function(Failure)? telemetryOnError,
    FutureOr<void> Function()? telemetryOnSuccess,
  })  : _isar = isar,
        _logger = logger,
        _telemetryOnError = telemetryOnError,
        _telemetryOnSuccess = telemetryOnSuccess;

  Result<IsarCollection<I, M>> _getCollection() {
    _logger?.d('[Process] Getting collection from storage');

    return Result.guard(
      () => _isar.collection<I, M>(),
      onError: (e, s) {
        _logger?.e('[Error] Error getting collection from storage',
            error: e, stackTrace: s);
        _telemetryOnError?.call(
          LocalStorageInitializationFailure(error: e.toString(), stackTrace: s),
        );
        return LocalStorageInitializationFailure(
          error: e.toString(),
          stackTrace: s,
        );
      },
    );
  }

  @override
  Result<void> delete({required I id}) {
    _logger?.d('[Start] Deleting data with id $id from storage');

    final collectionResult = _getCollection();

    switch (collectionResult) {
      case Success<IsarCollection<I, M>>(value: final collectionResult):
        return Result.guard(
          () {
            final deleteResult = _isar.write(
              (isar) => collectionResult.delete(id),
            );
            if (!deleteResult) {
              throw LocalStorageWriteFailure(
                error: 'Error deleting item with id: $id',
                stackTrace: StackTrace.current,
              );
            }

            _logger?.d(
                '[Success] Successfully deleted data with id $id from storage');

            _telemetryOnSuccess?.call();
          },
          onError: (e, s) {
            late Failure failure;

            switch (e) {
              case LocalStorageWriteFailure():
                failure = e;
                break;
              default:
                failure = LocalStorageWriteFailure(
                  error: e.toString(),
                  stackTrace: s,
                );
                break;
            }

            _logger?.e('[Error] Error deleting data with id $id from storage',
                error: e, stackTrace: s);

            _telemetryOnError?.call(failure);

            return failure;
          },
        );

      case Error<IsarCollection<I, M>>(exception: final failure):
        return Result.error(failure);
    }
  }

  @override
  Result<void> deleteAll() {
    _logger?.d('[Start] Deleting all data from storage');

    final collectionResult = _getCollection();

    switch (collectionResult) {
      case Success<IsarCollection<I, M>>(value: final collectionResult):
        return Result.guard(
          () {
            _isar.write(
              (isar) => collectionResult.clear(),
            );

            _logger?.d('[Success] Successfully deleted all data from storage');

            _telemetryOnSuccess?.call();
          },
          onError: (e, s) {
            final Failure failure = LocalStorageWriteFailure(
              error: e.toString(),
              stackTrace: s,
            );

            _logger?.e('[Error] Error deleting all data from storage',
                error: e, stackTrace: s);

            _telemetryOnError?.call(failure);

            return failure;
          },
        );

      case Error<IsarCollection<I, M>>(exception: final failure):
        return Result.error(failure);
    }
  }

  @override
  Result<M> read({required I id}) {
    _logger?.d('[Start] Reading data with id $id from storage');

    final collectionResult = _getCollection();

    switch (collectionResult) {
      case Success<IsarCollection<I, M>>(value: final collectionResult):
        return Result.guard(
          () {
            final result = collectionResult.get(id);
            if (result == null) {
              throw LocalStorageValueNotFound(
                value: 'No value found for id $id',
                error: 'Error, value not found for id: $id',
                stackTrace: StackTrace.current,
              );
            }

            _logger?.d(
                '[Success] Successfully read data with id $id from storage');

            _telemetryOnSuccess?.call();

            return result;
          },
          onError: (e, s) {
            late Failure failure;

            switch (e) {
              case LocalStorageValueNotFound():
                failure = e;
                break;
              default:
                failure = LocalStorageReadFailure(
                  error: e.toString(),
                  stackTrace: s,
                );
                break;
            }

            _logger?.e('[Error] Error reading data with id $id from storage',
                error: e, stackTrace: s);

            _telemetryOnError?.call(failure);

            return failure;
          },
        );

      case Error<IsarCollection<I, M>>(exception: final failure):
        return Result.error(failure);
    }
  }

  @override
  Result<void> save({required M value}) {
    _logger?.d('[Start] Saving data with value $value to storage');

    final collectionResult = _getCollection();

    switch (collectionResult) {
      case Success<IsarCollection<I, M>>(value: final collectionResult):
        return Result.guard(
          () {
            _isar.write(
              (isar) => collectionResult.put(value),
            );

            _logger?.d(
                '[Success] Successfully saved data with value $value to storage');

            _telemetryOnSuccess?.call();
          },
          onError: (e, s) {
            final Failure failure = LocalStorageWriteFailure(
              error: e.toString(),
              stackTrace: s,
            );

            _logger?.e('[Error] Error saving data with value $value to storage',
                error: e, stackTrace: s);

            _telemetryOnError?.call(failure);

            return failure;
          },
        );

      case Error<IsarCollection<I, M>>(exception: final failure):
        return Result.error(failure);
    }
  }

  @override
  Result<List<M>> readAll() {
    _logger?.d('[Start] Reading all data from storage');

    final collectionResult = _getCollection();

    switch (collectionResult) {
      case Success<IsarCollection<I, M>>(value: final collectionResult):
        return Result.guard(
          () {
            final result = collectionResult.where().findAll();
            if (result.isEmpty) {
              return [];
            }

            _logger?.d('[Success] Successfully read all data from storage');

            _telemetryOnSuccess?.call();

            return result;
          },
          onError: (e, s) {
            final Failure failure = LocalStorageReadFailure(
              error: e.toString(),
              stackTrace: s,
            );

            _logger?.e('[Error] Error reading all data from storage',
                error: e, stackTrace: s);

            _telemetryOnError?.call(failure);

            return failure;
          },
        );

      case Error<IsarCollection<I, M>>(exception: final failure):
        return Result.error(failure);
    }
  }

  @override
  Result<void> saveAll({required List<M> values}) {
    _logger?.d('[Start] Saving all data with values $values to storage');

    final collectionResult = _getCollection();

    switch (collectionResult) {
      case Success<IsarCollection<I, M>>(value: final collectionResult):
        return Result.guard(
          () {
            _isar.write(
              (isar) => collectionResult.putAll(values),
            );

            _logger?.d(
                '[Success] Successfully saved all data with values $values to storage');

            _telemetryOnSuccess?.call();
          },
          onError: (e, s) {
            final Failure failure = LocalStorageWriteFailure(
              error: e.toString(),
              stackTrace: s,
            );

            _logger?.e(
                '[Error] Error saving all data with values $values to storage',
                error: e,
                stackTrace: s);

            _telemetryOnError?.call(failure);

            return failure;
          },
        );

      case Error<IsarCollection<I, M>>(exception: final failure):
        return Result.error(failure);
    }
  }
}
