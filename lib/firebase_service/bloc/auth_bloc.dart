import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        login: (email, password) async {
          emit(const AuthState.loading());
          try {
            final userId = await authRepository.login(email, password);
            emit(AuthState.authenticated(userId: userId));
          } catch (e) {
            emit(AuthState.error(message: e.toString()));
          }
        },
        signup: (email, password) async {
          emit(const AuthState.loading());
          try {
            final userId = await authRepository.signup(email, password);
            emit(AuthState.authenticated(userId: userId));
          } catch (e) {
            emit(AuthState.error(message: e.toString()));
          }
        },
        logout: () async {
          print('Logout initiated'); // Debugging
          await authRepository.logout(); // Ensure this method is working
          print('Logout successful'); // Debugging
          emit(const AuthState.unauthenticated());
        },

      );
    });
  }
}
