import 'package:flutter/material.dart';
import 'package:the_social/screens/login_screen.dart';

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_social/model/user_model_reg.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final _fAuth = FirebaseAuth.instance;

  User? user = FirebaseAuth.instance.currentUser;

  UserModelReg currUser = UserModelReg();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.currUser = UserModelReg.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 180,
                  child: Image.asset("assets/images/logo.jpg"),
                ),
                // ignore: prefer_const_constructors
                Text(
                  "Welcome to The Social",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Name : " + currUser.name.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text("Email : " + currUser.email.toString(),
                    style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 20,
                ),
                ActionChip(
                  label: Text("Logout"),
                  onPressed: () {
                    // _fAuth
                    //     .signOut()
                    //     .then((value) => {
                    //           Fluttertoast.showToast(msg: "Logging out"),
                    //           Navigator.of(context).pushReplacement(
                    //               MaterialPageRoute(
                    //                   builder: (context) => LoginScreen())),
                    //         })
                    //     .catchError((e) {
                    //   Fluttertoast.showToast(msg: e.toString());
                    // });

                    // --------------
                    logout(context);
                  },
                  backgroundColor: Colors.blue,
                )
              ]),
        )),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
