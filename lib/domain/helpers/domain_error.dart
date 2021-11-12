enum DomainError {
  unexpected,
  invalidCredentials,
}

extension DomainErrorExtension on DomainError {
  String get errorMessage {
    switch (this) {
      case DomainError.invalidCredentials:
        return 'Credenciais inválidas';
      default:
        return 'Ocorreu um erro. Tente novamente em breve.';
    }
  }
}