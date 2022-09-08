// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class DataStoreInFirebase extends StatefulWidget {
//   const DataStoreInFirebase({Key? key}) : super(key: key);

//   @override
//   State<DataStoreInFirebase> createState() => _DataStoreInFirebaseState();
// }

// class _DataStoreInFirebaseState extends State<DataStoreInFirebase> {
//   CollectionReference users = FirebaseFirestore.instance.collection("users");

//   String? textNote;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             TextField(
//               onChanged: (value) {
//                 textNote = value;
//               },
//               decoration: const InputDecoration(hintText: "Enter a note"),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await users.add(
//                   {
//                     "name": "pqr",
//                     "age": 23,
//                     "notes": textNote,
//                   },
//                 ).then(
//                   (value) => log("user added"),
//                 );
//               },
//               child: const Text("submit data"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
