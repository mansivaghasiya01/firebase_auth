import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';
//import 'package:email_validator/email_validator.dart';
import 'package:login_logout_firbase/component/textField_component.dart';
import 'package:login_logout_firbase/views/google_facebook_login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool? success;
  String? userEmail;
  String error = "";
  bool _passwordVisible = true;

  Future<void> register() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user!;

    // ignore: unnecessary_null_comparison
    if (user != null) {
      setState(() {
        success = true;
        userEmail = user.email;
      });
    } else {
      setState(() {
        success = true;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
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
                    "Sign Up",
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
                  controller: nameController,
                  label: "Enter name",
                  icon: const Icon(Icons.person),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return "please enter name";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldComponent(
                  controller: mobileNoController,
                  label: "Enter Mobile number",
                  icon: const Icon(Icons.phone),
                  validator: (value) {
                    String pattern = r'[0-9]';
                    RegExp regExp1 = RegExp(pattern);
                    if (value != null) {
                      if (value.isEmpty) {
                        return "please enter Mobile Number";
                      } else if (value.length != 10) {
                        return "Mobile number should be 10 number only";
                      } else if (regExp1.hasMatch(value)) {
                        return " mobile number should be numeric only";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
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
                TextFieldComponent(
                  controller: passwordController,
                  label: "Enter password",
                  icon: const Icon(Icons.password),
                  obscureText: _passwordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    // String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    // RegExp regExp1 = RegExp(pattern);
                    if (value != null) {
                      if (value.isEmpty) {
                        return "please enter password";
                      } else if (value.length != 6) {
                        return "Mobile number should be 6 number only";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (formKey.currentState!.validate()) {
                        await register();
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'user Already exist, please try another email address')));
                    }
                    setState(() {
                      if (error == "" && emailController.text.isNotEmpty) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginClass(),
                            ),
                            (Route<dynamic> route) => false);
                      } else if (error ==
                          "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'user Already exist, please try another email address')));
                      }
                    });

                    // if (formKey.currentState!.validate() &&
                    //     myValue.isNotEmpty) {
                    //   await register();

                    //   // ignore: use_build_context_synchronouslyabcd123@gmail.com
                    //   Navigator.of(context).pushAndRemoveUntil(
                    //       MaterialPageRoute(
                    //           builder: (context) => const LoginClass()),
                    //       (Route<dynamic> route) => false);
                    // } else if (myValue.isEmpty) {
                    //   Fluttertoast.showToast(msg: "please select gender");
                    // }
                  },
                  child: const Text('Submit'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(success == null
                      ? ''
                      : (success!
                          ? 'Successfully registered : \n${userEmail!}'
                          : 'Registration failed')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
