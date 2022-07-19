import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late String loggedInUser;

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    await _auth.signInWithEmailAndPassword(
      email: "bbb@gmail.com",
      password: "123456",
    );
    loggedInUser = _auth.currentUser?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'สถานที่โปรด',
        ),
        backgroundColor: kMainColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection(kFavoriteCollection)
            .where('email', isEqualTo: loggedInUser)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: snap.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snap[index]['location'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    snap[index]['address'],
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: kMainColor,
                    onPressed: () async {
                      await _firestore
                          .collection(kFavoriteCollection)
                          .doc(snap[index].id)
                          .delete();
                    },
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
