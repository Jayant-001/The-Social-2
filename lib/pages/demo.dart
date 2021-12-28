import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_social/model/user_model_reg.dart';

//______________image upload________________
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class demovw extends StatefulWidget {
  demovw({Key? key}) : super(key: key);
  @override
  _demovwState createState() => _demovwState();
}

class _demovwState extends State<demovw> {
  UploadTask? task;
  String currenturl = "null";
  int t = 0;
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
      setState(() {
        currenturl = currUser.dpurl.toString();
        if (currenturl == "null")
          currenturl =
              "https://firebasestorage.googleapis.com/v0/b/the-social-5ba4c.appspot.com/o/dp.jfif?alt=media&token=e2189c61-9022-4614-939c-6d43fadc2175";
      });
    });
  }

  File? image;
  Future getimg(ImageSource source) async {
    try {
      final image = (await ImagePicker().pickImage(source: source));
      if (image == null) return;

      final imagetemp = File(image.path);
      setState(() {
        this.image = imagetemp;
        t = 1;
        print("image captured");
      });
    } on PlatformException catch (e) {
      // TODO
      print("Permission denied");
    }
  }

  Future uploadfile() async {
    if (image == null) return;
    final filename = basename(image!.path);
    final dest = 'images/$filename';
    FirebaseApi.uploadfile(dest, image!);
    task = FirebaseApi.uploadfile(dest, image!);
    setState(() {});
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urldownload = await snapshot.ref.getDownloadURL();
    print(urldownload);
    updatedpurl(urldownload, currUser.name, currUser.email, currUser.password,
        currUser.uid);
  }

  Future updatedpurl(updpurl, name, mail, pass, id) async {
    final _fAuth = FirebaseAuth.instance;

    User? user = FirebaseAuth.instance.currentUser;

    UserModelReg currUser = UserModelReg();

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    currUser.dpurl = updpurl;
    currUser.name = name;
    currUser.email = mail;
    currUser.uid = id;
    currUser.password = pass;

    await firebaseFirestore
        .collection("users")
        .doc(user!.uid)
        .set(currUser.toMap());
    setState(() {
      currenturl = currUser.dpurl.toString();
      t = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    //fetching details
    // String name = "Prashant Pal";

    String college = "KIET GROUP OF INSTITUITION";
    String school = "KENDRIYA VIDYALAYA RRC FATEHGARH";
    List hobbie = ['hbb1', 'hbb2', 'hbb3', 'hbb4', 'hbb5'];
    List interest = [
      'interest1',
      'interest2',
      'interest3',
      'interest4',
      'interest5'
    ];
    // final imageop = "assets/images/dp.jfif"; // url address to open image
    final image2 = AssetImage("assets/images/clglogo.png");
    final image3 = AssetImage("assets/images/schlogo.png");
    // giving address of image
    //final img = AssetImage("assets/images/dp.jfif"); // NetworkImage("url")
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.12),
        body: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max,
              //physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white,
                  child: Column(children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            // color: Colors.white,
                            height: 150,
                            width: 400,
                          ),
                          Positioned(
                            bottom: 10,
                            right: 125,
                            child: ClipOval(
                              child: GestureDetector(
                                onTap: () {
                                  //here give functionality to profile image
                                  print("Enlarge Proflie image");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ImageScreen(urlimg: currenturl),
                                    ),
                                  );
                                },
                                child: Material(
                                    child: Image.network(
                                  currenturl,
                                  height: 128, //Profile image
                                  width: 128,
                                  fit: BoxFit.cover,
                                )),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 10,
                              right: 125,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(3),
                                  child: ClipOval(
                                    child: Container(
                                        padding: EdgeInsets.all(8),
                                        color: Colors.blue,
                                        child: GestureDetector(
                                            child: Icon(
                                              Icons.edit,
                                              size: 24,
                                              color: Colors.white,
                                            ),
                                            //here give functionality to edit image
                                            onTap: () {
                                              print("Edit Image");
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) => Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(
                                                            Icons.camera_alt),
                                                        title: Text(
                                                            "Take From Camera "),
                                                        onTap: () {
                                                          getimg(ImageSource
                                                              .camera);
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: Icon(Icons
                                                            .now_wallpaper_outlined),
                                                        title: Text(
                                                            "Chosse from gallery"),
                                                        onTap: () {
                                                          getimg(ImageSource
                                                              .gallery);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Text(currUser.name.toString(),
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text("$college",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.7))),
                        if (t != 0)
                          ButtonWidget(
                            text: 'Upload image',
                            icon: Icons.cloud_upload_outlined,
                            onclicked: uploadfile,
                          ),
                      ]),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),

                //Card for personal info
                Card(
                  color: Colors.white,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(children: [
                      ListTile(
                        leading: Text("Personal Info :-",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20)),
                      ),
                      ListTile(
                          title: Text(
                            currUser.name.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                          leading: Icon(
                            Icons.account_circle,
                            size: 30,
                          )),
                      ListTile(
                          title: Text(
                            "Fatehgarh",
                            style: TextStyle(fontSize: 16),
                          ),
                          leading: Icon(
                            Icons.location_pin,
                            size: 30,
                          )),
                      ListTile(
                          title: Text(
                            currUser.email.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                          leading: Icon(
                            Icons.email_outlined,
                            size: 30,
                          )),
                      ListTile(
                          title: Text(
                            "Delhi",
                            style: TextStyle(fontSize: 16),
                          ),
                          leading: Icon(
                            Icons.work_rounded,
                            size: 30,
                          )),
                      ListTile(
                          title: Text(
                            "05 August",
                            style: TextStyle(fontSize: 16),
                          ),
                          leading: Icon(
                            Icons.cake_rounded,
                            size: 30,
                          )),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //Card for education
                Card(
                    color: Colors.white,
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(children: [
                          ListTile(
                            leading: Text("Education :-",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20)),
                          ),
                          ListTile(
                              title: Text("$college"),
                              leading: ClipOval(
                                child: Material(
                                    child: Ink.image(
                                  image: image2,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                )),
                              )),
                          ListTile(
                              title: Text("$school"),
                              leading: ClipOval(
                                child: Material(
                                    child: Ink.image(
                                  image: image3,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                )),
                              ))
                        ]))),
                //Card for interests
                SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Interest :-",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        height: 80,
                        child: ListView.builder(
                          itemCount: interest.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              interest[index],
                              style: TextStyle(fontSize: 16),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Hobbies :-",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        height: 80,
                        child: ListView.builder(
                          itemCount: hobbie.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              hobbie[index],
                              style: TextStyle(fontSize: 16),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ]),
        ));
  }
}

//__________________________Image Enlarge Widget_____________________________________________

class ImageScreen extends StatefulWidget {
  ImageScreen({Key? key, required this.urlimg}) : super(key: key);
  String urlimg;
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            // go back to previous page
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Card(
        child: Center(
          child: Container(
              alignment: Alignment.center,
              height: 400,
              width: 400,
              color: Colors.white,
              child: DecoratedBox(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.network(
                    widget.urlimg,
                    fit: BoxFit.fill,
                  ))),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onclicked})
      : super(key: key);
  final IconData icon;
  final String text;
  final VoidCallback onclicked;
  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(29, 194, 95, 1),
          minimumSize: Size.fromHeight(50),
        ),
        child: buildcontent(),
        onPressed: onclicked,
      );

  Widget buildcontent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            text,
            style: (TextStyle(fontSize: 22, color: Colors.black)),
          )
        ],
      );
}

class FirebaseApi {
  static UploadTask? uploadfile(String dest, File image) {
    try {
      final ref = FirebaseStorage.instance.ref(dest);
      return ref.putFile(image);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
