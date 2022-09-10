// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_logout_firbase/views/phone_auth.dart';

class PhoneAuthHomeScreen extends StatefulWidget {
  const PhoneAuthHomeScreen({Key? key}) : super(key: key);

  @override
  _PhoneAuthHomeScreenState createState() => _PhoneAuthHomeScreenState();
}

class _PhoneAuthHomeScreenState extends State<PhoneAuthHomeScreen> {
  String? uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Auth HomeScreen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PhoneAuthScreen(),
                  ),
                  (route) => false);
            },
          )
        ],
      ),
      body: Center(
        child: Text(uid!),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }
}
