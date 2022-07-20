import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
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
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),

          /// Retrieve favorite places from firebase, from favorite collection
          /// Check if the data belongs to the logged in user or not
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection(kFavoriteCollection)
                .where('email', isEqualTo: loggedInUser)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final snap = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: snap.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      /// Get both location and address
                      title: Text(
                        snap[index]['location'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        snap[index]['address'],
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),

                      /// Delete the place after pressing on the delete icon
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          size: 40,
                        ),
                        color: kMainColor,
                        onPressed: () async {
                          await _firestore
                              .collection(kFavoriteCollection)
                              .doc(snap[index].id)
                              .delete();
                        },
                      ),
                      minVerticalPadding: 10,
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
