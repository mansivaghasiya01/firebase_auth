import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_logout_firbase/component/textField_component.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: resetPasswordContext(),
    );
  }

  //---------------------------- helper function ------------------------------------

  Widget resetPasswordContext() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "https://img.freepik.com/free-vector/coach-speaking-before-audience-mentor-presenting-charts-reports-employees-meeting-business-training-seminar-conference-vector-illustration-presentation-lecture-education_74855-8294.jpg?w=2000",
                    width: 170,
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Reset password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.lightBlueAccent),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldComponent(
                controller: emailController,
                label: "Enter Email",
                icon: const Icon(Icons.email),
                validator: (value) {
                  // String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                  // RegExp regExp1 = RegExp(pattern);
                  if (value != null) {
                    if (value.isEmpty) {
                      return "please enter email";
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(
                        email: emailController.text,
                      )
                      .then((value) => Navigator.of(context).pop());
                },
                child: const Text("Reset Password"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
