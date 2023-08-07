import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> login({required email, required password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFail(errMessage: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFail(errMessage: 'wrong password'));
      } else if (e.code == 'invalid-email') {
        emit(LoginFail(errMessage: "invalid email"));
      }
    } on Exception catch (e) {
      emit(LoginFail(errMessage: "something went wrong "));
    }
  }
}
