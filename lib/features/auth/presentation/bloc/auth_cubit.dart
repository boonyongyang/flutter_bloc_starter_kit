import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(const AuthState.initial()) {
    checkAuthenticationStatus();
  }

  Future<void> checkAuthenticationStatus() async {
    emit(const AuthState.loading());
    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        final username = await _authService.getCurrentUsername();
        emit(AuthState.authenticated(username: username ?? 'User'));
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (e) {
      emit(AuthState.error(
          'Failed to check authentication status: ${e.toString()}'));
    }
  }

  Future<void> login(String username, String password) async {
    emit(const AuthState.loading());
    try {
      await _authService.login(username, password);
      emit(AuthState.authenticated(username: username));
    } catch (e) {
      emit(AuthState.error('Login failed: ${e.toString()}'));
    }
  }

  Future<void> logout() async {
    emit(const AuthState.loading());
    try {
      await _authService.logout();
      emit(const AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(
        'Logout failed: ${e.toString()}',
      ));
    }
  }
}
