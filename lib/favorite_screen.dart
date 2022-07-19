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
      body: Column(
        children: [
          ListTile(
            title: Text(
              'มหาวิทยาลัยมหิดล',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: kMainColor,
              ),
            ),
            subtitle: Text(
              '999 ถนนพุทธมณฑลสาย 4 ตำบลศาลายา อำเภอพุทธมณฑล นครปฐม 73170',
              style: TextStyle(
                fontSize: 13,
                color: kMainColor,
              ),
            ),
            trailing: IconButton(
                icon: Icon(Icons.delete),
                color: kMainColor,
                onPressed: () async {
                  final favorites = await _firestore
                      .collection(kFavoriteCollection)
                      .where('email', isEqualTo: loggedInUser)
                      .where('location', isEqualTo: 'xxx')
                      .get();
                  // _firestore.collection(kFavoriteCollection)
                  // .doc(favorites.id).delete()
                }),
          ),
        ],
      ),
    );
  }

  void getFavorites() async {
    final favorites = await _firestore
        .collection(kFavoriteCollection)
        .where('email', isEqualTo: loggedInUser)
        .get();
    for (var favorite in favorites.docs) {
      String favString =
          favorite.get('location') + ' - ' + favorite.get('address');
      print(favString);
    }
  }
}
