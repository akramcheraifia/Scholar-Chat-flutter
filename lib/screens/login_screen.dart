import 'package:chatapp/components/constants.dart';
import 'package:chatapp/components/custum_textfield.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_button.dart';
import '../helper/snack_message.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        hintText: "Email",
                        onChanged: (value) {
                          email = value;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    CustumTextField(
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
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await login();
                            Navigator.pushNamed(context, ChatScreen.id);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              snackMessage(
                                  context, "No user found for that email.");
                            } else if (e.code == 'wrong-password') {
                              snackMessage(context,
                                  "Wrong password provided for that user.");
                            } else if (e.code == 'invalid-email') {
                              snackMessage(
                                  context, "The email address is not valid.");
                            }
                          } catch (e) {
                            snackMessage(context, "Error Occured");
                          }
                          setState(() {
                            isLoading = false;
                          });
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
        ));
  }

  Future<void> login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
