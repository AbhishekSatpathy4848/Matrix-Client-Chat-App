// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: Login(),
  ));
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("SIGN UP",
              style: TextStyle(
                color: Colors.white,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.help,
                  )),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                      "lib/features/login_registration/assets/google.jpg"),
                  radius: 50,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                color: Colors.grey[900],
                child: Text(
                  'MatChat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 20),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      labelText: "@Username",
                      prefixIcon: Icon(Icons.person_2_rounded),
                      hintText: "@example123",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                          onPressed: () {},
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Text("SIGN IN",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ))),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: MaterialButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.blue,
                          child: Text("SIGN UP",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ))),
                    )
                  ],
                ),
              ),
              Divider(
                  endIndent: BorderSide.strokeAlignCenter, color: Colors.white),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Image(
                          height: 40,
                          width: 40,
                          image: AssetImage(
                              "lib/features/login_registration/assets/google.jpg"),
                        )),
                    Spacer(),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Image(
                          height: 40,
                          width: 40,
                          image: AssetImage(
                              "lib/features/login_registration/assets/github.jpg"),
                        )),
                    Spacer(),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Image(
                          height: 40,
                          width: 40,
                          image: AssetImage(
                              "lib/features/login_registration/assets/twitter.jpg"),
                        )),
                    Spacer(),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Image(
                          height: 40,
                          width: 40,
                          image: AssetImage(
                              "lib/features/login_registration/assets/facebook.png"),
                        )),
                  ],
                ),
              ),
              Spacer(),
              Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Contact Number : 1234567890",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    )),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Email : placeholder@gmail.com",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    )),
              ),
              Container(
                color: Colors.grey[800],
                child: Image(
                    height: 30,
                    width: 100,
                    image: AssetImage(
                        'lib/features/login_registration/assets/matrix.png')),
              )
            ],
          ),
        ));
  }
}
