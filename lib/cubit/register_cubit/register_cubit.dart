import 'package:bloc/bloc.dart';
import 'package:chatapp/helper/snack_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser({required email, required password}) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFail(errMessage: "The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFail(errMessage: "email already in use"));
      } else if (e.code == 'invalid-email') {
        emit(RegisterFail(errMessage: "invalid email"));
      }
    } on Exception catch (e) {
      emit(RegisterFail(errMessage: "something went wrong "));
    }
  }
}
