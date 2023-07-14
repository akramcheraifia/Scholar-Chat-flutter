import 'package:chatapp/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_button.dart';
import '../components/custum_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = "register_screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustumTextField(
                        hintText: "Email",
                        onChanged: (data) {
                          email = data;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustumTextField(
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
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await registerUser();
                              Navigator.pushNamed(context, ChatScreen.id);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                snackMessage(context,
                                    "The password provided is too weak.");
                              } else if (e.code == 'email-already-in-use') {
                                snackMessage(context,
                                    "The account already exists for that email.");
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
        ));
  }

  void snackMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
