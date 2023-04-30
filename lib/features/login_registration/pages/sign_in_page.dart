

import 'dart:ui';
import '/features/login_registration/pages/login_home.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class SignIn extends StatefulWidget {
  final String userName;
  const SignIn({super.key,required this.userName});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final TextEditingController _homeserverTextField = TextEditingController(text: "matrix.org");
  final TextEditingController _passwordTextField = TextEditingController();
  bool _loading = false;
  late String userName;

  void _login() async {
    setState(() {
      _loading = true;
    });

  try {
      final client = Provider.of<Client>(context, listen: false);
      await client
          .checkHomeserver(Uri.https(_homeserverTextField.text.trim(), ''));
      await client.login(
        LoginType.mLoginPassword,
        password: _passwordTextField.text,
        identifier: AuthenticationUserIdentifier(user: userName),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Placeholder()),       //put room list page here
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      setState(() {
        _loading = false;
      });
    }
  }  

  @override
  void initState(){
    super.initState();
    userName = widget.userName;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("SIGN IN",
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                
                controller: _passwordTextField,


                autocorrect: false,
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
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MaterialButton(
                onPressed: _loading ? null : _login,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
                  child: Text(
                    "SIGN IN",
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
