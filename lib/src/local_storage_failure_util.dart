import 'package:flutter/widgets.dart';
import 'package:local_storage_client/localization/local_storage_localizations.dart';
import 'package:local_storage_client/src/local_storage_failure.dart';

class LocalStorageFailureUtil {
  static String getFailureNameUI({
    required BuildContext context,
    required LocalStorageFailure failure,
  }) {
    switch (failure) {
      case LocalStorageReadFailure():
        return LocalStorageLocalizations.of(context)!.readFailure;
      case LocalStorageWriteFailure():
        return LocalStorageLocalizations.of(context)!.writeFailure;
      case LocalStorageInitializationFailure():
        return LocalStorageLocalizations.of(context)!.initializationFailure;
      case LocalStorageKeyNotFound():
        return LocalStorageLocalizations.of(context)!.keyNotFoundFailure;
      case LocalStorageValueNotFound():
        return LocalStorageLocalizations.of(context)!.valueNotFoundFailure;
    }
  }
}
