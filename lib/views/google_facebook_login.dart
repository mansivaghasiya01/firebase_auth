// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

//import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_logout_firbase/component/textField_component.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_logout_firbase/views/User_home_screen.dart';
import 'package:login_logout_firbase/views/sign_up_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();

class LoginClass extends StatefulWidget {
  const LoginClass({Key? key}) : super(key: key);

  @override
  State<LoginClass> createState() => _LoginClassState();
}

class _LoginClassState extends State<LoginClass> {
  //--------------------------------------- Variable ----------------------------------//
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? success;
  final formGlobalKey = GlobalKey<FormState>();
  String? uid;
  String? userEmail;
  bool _passwordVisible = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildView(),
    );
  }

  //-------------------------helper widget---------------------------

  Widget buildView() {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: formGlobalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "images/login_app_photo.jpg",
                      fit: BoxFit.fill,
                      width: 170,
                      height: 150,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.lightBlueAccent),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFieldComponent(
                  controller: emailController,
                  label: "Enter Email",
                  icon: const Icon(Icons.email),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return "please enter email";
                      }
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFieldComponent(
                  controller: passwordController,
                  obscureText: _passwordVisible,
                  label: "Enter password",
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
                  icon: const Icon(Icons.password),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return "please enter password";
                      } else if (value.length != 6) {
                        return "password should be 6 number only";
                      }
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (formGlobalKey.currentState!.validate()) {
                      await signInWithEmailAndPassword();

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const UserHomePage(),
                          ),
                          (Route<dynamic> route) => false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent,
                    fixedSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //---------------------google-----------
                    InkWell(
                      onTap: () {
                        _logInWithGoogle();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "images/google_logo.jpg",
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),

                    //------------------facebook----------------------
                    InkWell(
                      onTap: () {
                        _logInWithFacebook();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "images/facebook_image.jpg",
                          height: 40,
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(success == null
                    ? ''
                    : (success!
                        ? 'Successfully registered : \n${userEmail!} \n $uid'
                        : 'Registration failed')),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an Account ?",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text("Sign Up"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //-------------------------------------- function ---------------------------------//

  Future<void> signInWithEmailAndPassword() async {
    final User user = (await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user!;

    // ignore: unnecessary_null_comparison
    if (user != null) {
      setState(() {
        success = true;
        userEmail = user.email;
        uid = user.uid;
      });
    } else {
      setState(() {
        success = false;
      });
    }
  }

  //------------facebook login function----------------------

  void _logInWithFacebook() async {
    setState(() {
      isLoading = true;
    });

    try {
      final facebookLoginResult =
          await FacebookAuth.instance.login(permissions: ['email']);
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      await FirebaseFirestore.instance.collection("users").add({
        "email": userData["email"],
        "imageUrl": userData["picture"]["data"]["url"],
        "name": userData["name"]
      });

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => const UserHomePage())),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      var content = "";
      switch (e.code) {
        case "account-exists-with-different-credential":
          content = "this account exixts with a different sign in provider";
          break;
        case "invalid-credential":
          content = "Unknown error has occurred";
          break;
        case "operation-not-allowed":
          content = "This operation is not allowed";
          break;
        case "User-disabled":
          content = "The user you tried to log into is disabled";
          break;
        case "User-not-found":
          content = "The user you tried to log into was not found";
          break;
      }
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Log in with facebook failed"),
                content: Text(content),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ok"),
                  ),
                ],
              ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  //---------------------------google login function-------------------------

  void _logInWithGoogle() async {
    setState(() {
      isLoading = true;
    });
    final googleSignIn = GoogleSignIn(scopes: ["email"]);

    try {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      final GoogleSignInAuthentication =
          await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: GoogleSignInAuthentication.accessToken,
          idToken: GoogleSignInAuthentication.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      await FirebaseFirestore.instance.collection("users").add({
        "email": googleSignInAccount.email,
        "imageUrl": googleSignInAccount.photoUrl,
        "name": googleSignInAccount.displayName
      });

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => const UserHomePage())),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      var content = "";
      switch (e.code) {
        case "account-exists-with-different-credential":
          content = "this account exixts with a different sign in provider";
          break;
        case "invalid-credential":
          content = "Unknown error has occurred";
          break;
        case "operation-not-allowed":
          content = "This operation is not allowed";
          break;
        case "User-disabled":
          content = "The user you tried to log into is disabled";
          break;
        case "User-not-found":
          content = "The user you tried to log into was not found";
          break;
      }
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Log in with google failed"),
                content: Text(content),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ok"),
                  ),
                ],
              ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
