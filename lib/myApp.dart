// ignore: file_names
import 'package:flutter/material.dart';
import 'package:login_logout_firbase/provider/google_signin_provider.dart';
import 'package:login_logout_firbase/views/forget_password.dart';
import 'package:login_logout_firbase/views/google_facebook_login.dart';
import 'package:login_logout_firbase/views/phone_auth.dart';
import 'package:login_logout_firbase/views/sign_up_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ResetPassword(),
        ),
      );
}
