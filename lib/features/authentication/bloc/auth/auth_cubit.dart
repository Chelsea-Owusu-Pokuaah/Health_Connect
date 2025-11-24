import 'package:bloc/bloc.dart';
import 'auth_state.dart';
import '../../data/services/auth_service.dart';
import '../../data/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _auth;

  AuthCubit(this._auth) : super(AuthInitial());

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String role,
  }) async {
    emit(AuthLoading());

    try {
      final user = await _auth.signUp(
        fullName: fullName,
        email: email,
        password: password,
        role: role,
      );

      if (user == null) {
        emit(AuthFailure("Signup failed: no user returned."));
        return;
      }

      // convert to your UserModel
      final model = UserModel(
        uid: user.uid,
        fullName: fullName,
        email: email,
        role: role,
      );

      emit(AuthSuccess(model));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> login({
  required String email,
  required String password,
  }) async {
    emit(AuthLoading());

    try {
      final userModel = await _auth.login(
        email: email,
        password: password,
      );

      if (userModel == null) {
        emit(const AuthFailure("Invalid email or password"));
        return;
      }

      emit(AuthSuccess(userModel));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }


  Future<void> logout() async {
    await _auth.logout();
    emit(AuthInitial());
  }
}
