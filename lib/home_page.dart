import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_logout_firbase/views/User_home_screen.dart';
import 'package:login_logout_firbase/views/sign_up_page.dart';
//import 'package:login_logout_firbase/provider/googleSignInProvider.dart';

//import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const UserHomePage();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Somthing went wrong!"),
            );
          } else {
            return const SignUpPage();
          }
        },
      ),
    );
  }
}
