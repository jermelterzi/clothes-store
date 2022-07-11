import 'package:flutter/cupertino.dart';

class AuthException implements Exception {
  final String msg;

  Map<String, String> errors = {
    'EMAIL_NOT_FOUND': 'E-mail não encontrado.',
    'INVALID_PASSWORD': 'Senha informada não confere.',
    'USER_DISABLED': 'A conta do usuário foi desabilitada.',
    'EMAIL_EXISTS': 'Email já cadastrado.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida!',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Acesso bloqueado temporariamente. Tente mais tarde!',
  };

  AuthException(this.msg);

  @override
  String toString() {
    return errors[msg] ?? 'Ocorreu um erro no processo de autenticação';
  }
}
