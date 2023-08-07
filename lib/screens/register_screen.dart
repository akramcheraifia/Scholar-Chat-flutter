import 'package:chatapp/components/constants.dart';
import 'package:chatapp/cubit/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/custom_button.dart';
import '../components/custum_textfield.dart';
import '../helper/snack_message.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatelessWidget {
  String? email;

  String? password;
  static String id = "register_screen";

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatScreen.id);
          isLoading = false;
        } else if (state is RegisterFail) {
          snackMessage(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => Scaffold(
          backgroundColor: kPrimaryColor,
          body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Form(
              key: formKey,
              child: ListView(
                children: [
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
                              "SIGN UP",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustumTextField(
                          hide: false,
                          hintText: "Email",
                          onChanged: (data) {
                            email = data;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustumTextField(
                          hide: true,
                          hintText: "Password",
                          onChanged: (data) {
                            password = data;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            text: "REGISTER",
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<RegisterCubit>(context)
                                    .registerUser(
                                        email: email, password: password);
                              }
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Sign in",
                                  style: TextStyle(color: Colors.lightBlue),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
