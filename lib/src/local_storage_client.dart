import 'package:common_classes/common_classes.dart';

import 'local_storage_failure.dart';

/// [LocalStorageClient] is an abstract class that defines the methods
/// that are used to interact with the local storage
///
/// [I] is the type of the id of the storage db. If the id is a string, then
/// [I] is [String]. If the id is an integer, then [I] is [int] ...
///
/// [M] is the type of the model of the storage db. If the model is a string, then
/// [M] is [String]. If the model is an integer, then [M] is [int] ...
///
abstract class LocalStorageClient<I, M> {
  /// Save the data to the local storage
  ///
  /// [value] is the data to be saved and is of type [M]
  ///
  /// Throws [LocalStorageWriteFailure] if an error occurs while writing the data to storage
  ///
  /// Throws [LocalStorageInitializationFailure] if the local storage is not initialized
  ///
  Result<void> save({
    required M value,
  });

  /// Save a list of data to the local storage
  ///
  /// [values] is the list of data to be saved. Each data is of type [M]
  ///
  /// Throws [LocalStorageWriteFailure] if an error occurs while writing the data to storage
  ///
  /// Throws [LocalStorageInitializationFailure] if the local storage is not initialized
  ///
  Result<void> saveAll({
    required List<M> values,
  });

  /// Search for the data in the local storage with the given [id] of type [I]
  ///
  /// Returns an entity of type [M] if the data is found
  ///
  /// Throws [LocalStorageReadFailure] if an error occurs while reading the data from storage
  ///
  /// Throws [LocalStorageValueNotFound] if the data is not found
  ///
  /// Throws [LocalStorageInitializationFailure] if the local storage is not initialized
  ///
  Result<M> read({
    required I id,
  });

  /// [delete] deletes the data from the local storage
  ///
  /// [id] is the id of the data to be deleted and is of type [I]
  ///
  /// If not found, does nothing
  ///
  /// Throws [LocalStorageWriteFailure] if an error occurs while writing the data to storage
  ///
  /// Throws [LocalStorageInitializationFailure] if the local storage is not initialized
  ///
  Result<void> delete({
    required I id,
  });

  /// [deleteAll] deletes all the data from the local storage
  ///
  /// Throws [LocalStorageWriteFailure] if an error occurs while writing the data to storage
  ///
  /// Throws [LocalStorageInitializationFailure] if the local storage is not initialized
  ///
  Result<void> deleteAll();

  /// [readAll] reads all the data from the local storage
  ///
  /// Returns a list of entities of type [M]. If no data is found, returns an empty list
  ///
  /// Throws [LocalStorageReadFailure] if an error occurs while reading the data from storage
  ///
  /// Throws [LocalStorageInitializationFailure] if the local storage is not initialized
  ///
  Result<List<M>> readAll();
}
