import 'package:chatapp/components/constants.dart';
import 'package:chatapp/components/custum_textfield.dart';
import 'package:chatapp/cubit/chat_cubit/chat_cubit.dart';
import 'package:chatapp/cubit/login_cubit/login_cubit.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_button.dart';
import '../helper/snack_message.dart';
import 'chat_screen.dart';

class LoginScreen extends StatelessWidget {
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  static String id = "login_screen";
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatScreen.id);
          isLoading = false;
        } else if (state is LoginFail) {
          snackMessage(context, state.errMessage);
          isLoading = false;
        }
      },
      child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Form(
              key: formKey,
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 75,
                      ),
                      Image.asset('assets/images/scholar.png'),
                      const Text("Scholar Chat",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pacifico')),
                      const SizedBox(height: 75),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LOGIN",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustumTextField(
                          hide: false,
                          hintText: "Email",
                          onChanged: (value) {
                            email = value;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      CustumTextField(
                          hide: true,
                          hintText: "Password",
                          onChanged: (value) {
                            password = value;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: "LOG IN",
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context)
                                .login(email: email, password: password);
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Dont have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RegisterScreen.id);
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(color: Colors.lightBlue),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          )),
    );
  }
}
