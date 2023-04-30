// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'dart:ui';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
      body: Column(
        children: [
          SizedBox(
            height: 75,
          ),
          Form(
            key: _formKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    labelText: "PASSWORD",
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.lock_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    labelText: "CONFIRM PASSWORD",
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.lock_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    labelText: "EMAIL",
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.email_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Placeholder();
                    }));
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
