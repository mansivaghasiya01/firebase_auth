// ignore_for_file: library_private_types_in_public_api, unnecessary_const

import 'package:flutter/material.dart';
import 'package:login_logout_firbase/views/phone_otp_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Auth'),
      ),
      body: phoneauth(),
    );
  }

  Widget phoneauth() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 60),
            child: const Center(
              child: Text(
                'Phone Authentication',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40, right: 10, left: 10),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Phone Number',
                prefix: const Padding(
                  padding: EdgeInsets.all(4),
                  child: const Text('+91'),
                ),
              ),
              maxLength: 10,
              keyboardType: TextInputType.number,
              controller: _controller,
            ),
          )
        ]),
        Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OTPScreen(_controller.text),
                ),
              );
            },
            child: const Text(
              'Next',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
