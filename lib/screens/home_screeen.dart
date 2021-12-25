import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_social/model/user_model_reg.dart';
import 'package:the_social/screens/login_screen.dart';
import 'package:the_social/screens/profile.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fAuth = FirebaseAuth.instance;
  int _currentIndex = 1;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
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
              Text("Name: ${currUser.name}"),
              Text("Email: ${currUser.email}"),
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







//_______________________________________Bottom Navigation Bar__________________________________________________




      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items:[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            title: Text("Profile",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.home, color: Colors.black),
            title: Text(
              "Home",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.search, color: Colors.black),
            title: Text("Search",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.settings, color: Colors.black),
            title: Text("Setting",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              // ignore: void_checks
              Navigator.push(context,
                  MaterialPageRoute(
                  builder: (context) => pfview(name:currUser.name,mail: currUser.email,)
                ),
              );}
            }
            );},
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
