import 'local_storage_localizations.dart';

/// The translations for Portuguese (`pt`).
class LocalStorageLocalizationsPt extends LocalStorageLocalizations {
  LocalStorageLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get generalFailure => 'Ocorreu um erro interno. Por favor, tente novamente mais tarde. Se o problema persistir, entre em contato com o administrador do sistema';

  @override
  String get readFailure => 'Ocorreu um erro ao tentar acessar os dados criptografados';

  @override
  String get writeFailure => 'Ocorreu um erro ao tentar gravar os dados criptografados';

  @override
  String get initializationFailure => 'Ocorreu um erro ao tentar inicializar o armazenamento seguro';

  @override
  String get valueNotFoundFailure => 'Ocorreu um erro ao tentar acessar os dados criptografados. O valor não existe';

  @override
  String get keyNotFoundFailure => 'Ocorreu um erro ao tentar acessar os dados criptografados. A chave não existe';
}
