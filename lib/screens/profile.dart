import 'dart:ui';

import 'package:flutter/material.dart';

class pfview extends StatefulWidget {
  // const pfview({Key? key}) : super(key: key);
  @override
  _pfviewState createState() => _pfviewState();
}

class _pfviewState extends State<pfview> {
  @override
  Widget build(BuildContext context) {
    //fetching details
    String name = "Prashant Pal";
    String college = "KIET GROUP OF INSTITUITION";
    String school = "KENDRIYA VIDYALAYA RRC FATEHGARH";
    List hobbie = ['hbb1', 'hbb2', 'hbb3', 'hbb4', 'hbb5'];
    List interest = ['interest1', 'interest2', 'interest3','interest4','interest5'];
    final imageop = "assets/images/dp.jpg"; // url address to open image
    final image2 = AssetImage("assets/images/clglogo.png");
    final image3 = AssetImage("assets/images/schlogo.png");
    // giving address of image
    final image = AssetImage("assets/images/dp.jpg"); // NetworkImage("url")
    return Scaffold(
        backgroundColor: Colors.amber[50],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () {
              // go back to previous page
              // Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max,
              //physics: BouncingScrollPhysics(),
              children: [
                Card(
                  child: Column(children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.white,
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
                                      builder: (context) => ImageScreen(
                                        imgurl: imageop,
                                      ),
                                    ),
                                  );
                                },
                                child: Material(
                                    child: Ink.image(
                                  image: image,
                                  height: 128,
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
                                          //here give functionality to edit image
                                          onTap: () {
                                            print("Profile picture edit");
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Text("$name",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text("$college",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.7)))
                      ]),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),

                //Card for personal info
                Card(
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
                            "$name",
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
                            "user@gmail.com",
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
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        color: Colors.white,
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
                SizedBox(height: 20,),
                Card(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        color: Colors.white,
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

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key, this.imgurl}) : super(key: key);
  final imgurl;
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
                child: Image.asset(
                  widget.imgurl,
                  fit: BoxFit.cover,
                ),
              )),
        ),
      ),
    );
  }
}
