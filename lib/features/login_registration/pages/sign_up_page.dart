import 'dart:ui';
import '/features/login_registration/pages/login_home.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class SignUp extends StatefulWidget {
  final String userName;
  const SignUp({super.key, required this.userName});
  void register() {}
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _homeserverTextField =
      TextEditingController(text: "matrix.org");
  final TextEditingController _passwordTextField = TextEditingController();
  final TextEditingController _pass1 = TextEditingController();
  final TextEditingController _pass2 = TextEditingController();
  final TextEditingController _displayName = TextEditingController();
  bool _loading = false;
  late String userName;

  void _register() async {
    setState(() {
      _loading = true;
    });

    try {
      final client = Provider.of<Client>(context, listen: false);
      final navigator = Navigator.of(context);
      await client
          .checkHomeserver(Uri.https(_homeserverTextField.text.trim(), ''));
      await client.register(
        username: userName,
        initialDeviceDisplayName: _displayName.text,
        // LoginType.mLoginPassword,
        password: _passwordTextField.text,
        // identifier: AuthenticationUserIdentifier(user: userName),
      );
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) => const Placeholder()), //put room list page here
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
  void initState() {
    super.initState();
    userName = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    widget.userName;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("SIGN UP",
            style: TextStyle(
              color: Colors.white,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.help,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 75,
            ),
            Form(
              key: _formKey,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _displayName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }
                      return null;
                    },
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      labelText: "Display Name",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.person_2_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _pass1,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }
                      return null;
                    },
                    style: const TextStyle(
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
                    controller: _pass2,
                    obscureText: true,
                    validator: (value) {
                      if (_pass1.text != _pass2.text) {
                        return "Passwords don't match";
                      } else {
                        _passwordTextField.text = _pass1.text;
                      }
                      return null;
                    },
                    style: const TextStyle(
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
                    style: const TextStyle(
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
                        _loading ? null : _register;
                        return const Placeholder(); //place chat room list here
                      }));
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.blue,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
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
      ),
    );
  }
}
