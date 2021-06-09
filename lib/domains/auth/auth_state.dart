abstract class AuthState {}

class Unresolved extends AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  final String token;

  Authenticated(this.token);
}

class Failed extends AuthState {
  final String errorMessage;

  Failed(this.errorMessage);
}
