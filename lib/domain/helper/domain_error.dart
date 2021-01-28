enum DomainError {
  unexpected,
  invalidCredentials
}

extension DomainErrorExtension on DomainError {
  String get description {
    switch(this) {
      case DomainError.unexpected: return 'Erro inesperado';
      case DomainError.invalidCredentials: return 'Credenciais Inválidas';
      default: return '';
    }
  }
}
