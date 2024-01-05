import 'local_storage_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class LocalStorageLocalizationsEs extends LocalStorageLocalizations {
  LocalStorageLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get generalFailure => 'Se ha producido un error interno. Por favor, inténtelo de nuevo más tarde. Si el problema persiste, póngase en contacto con el administrador del sistema';

  @override
  String get readFailure => 'Se ha producido un error al intentar acceder a los datos';

  @override
  String get writeFailure => 'Se ha producido un error al intentar escribir los datos';

  @override
  String get initializationFailure => 'Se ha producido un error al intentar inicializar el almacenamiento';

  @override
  String get valueNotFoundFailure => 'Los datos cifrados no existen en el almacenamiento';

  @override
  String get keyNotFoundFailure => 'Se ha producido un error al intentar acceder a los datos. La clave es errónea o no existe';
}
