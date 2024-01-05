import 'local_storage_localizations.dart';

/// The translations for English (`en`).
class LocalStorageLocalizationsEn extends LocalStorageLocalizations {
  LocalStorageLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get generalFailure => 'An internal error has occurred. Please try again later. If the problem persists, please contact your administrator';

  @override
  String get readFailure => 'Error reading data from storage';

  @override
  String get writeFailure => 'Error writing data to storage';

  @override
  String get initializationFailure => 'Local storage could not be initialized';

  @override
  String get valueNotFoundFailure => 'Error value not found in local storage';

  @override
  String get keyNotFoundFailure => 'Error key not found in local storage';
}
