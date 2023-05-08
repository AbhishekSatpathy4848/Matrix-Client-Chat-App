import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:matrix_chat_app/features/login_registration/pages/sign_up_page.dart';
import 'package:matrix_chat_app/features/login_registration/pages/sign_in_page.dart';

class Login extends StatefulWidget {
  // final Client client;
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final TextEditingController _usernameTextField = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text("LOGIN",
              style: TextStyle(
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.help,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                      "lib/features/login_registration/assets/matrix_icon.png"),
                  radius: 50,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const Text(
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
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _usernameTextField,
                      autocorrect: false,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.person_2_rounded,
                          color: Colors.white,
                        ),
                        hintText: "example123",
                      ),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return SignIn(
                                  userName: _usernameTextField.text,
                                );
                              }));
                            }
                          },
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: const Text("SIGN IN",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ))),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return SignUp(
                                  userName: _usernameTextField.text,
                                );
                              }));
                            }
                            ;
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.blue,
                          child: const Text("SIGN UP",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ))),
                    )
                  ],
                ),
              ),
//              Divider(
//                  endIndent: BorderSide.strokeAlignCenter, color: Colors.white),
//              Padding(
//                padding: const EdgeInsets.all(25.0),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: const [
//                    Padding(
//                        padding: EdgeInsets.all(10.0),
//                        child: Image(
//                          height: 40,
//                          width: 40,
//                          image: AssetImage(
//                              "lib/features/login_registration/assets/google.jpg"),
//                        )),
//                    Spacer(),
//                    Padding(
//                        padding: EdgeInsets.all(10.0),
//                        child: Image(
//                          height: 40,
//                          width: 40,
//                          image: AssetImage(
//                              "lib/features/login_registration/assets/github.jpg"),
//                        )),
//                    Spacer(),
//                    Padding(
//                        padding: EdgeInsets.all(10.0),
//                        child: Image(
//                          height: 40,
//                          width: 40,
//                          image: AssetImage(
//                              "lib/features/login_registration/assets/twitter.jpg"),
//                        )),
//                    Spacer(),
//                    Padding(
//                        padding: EdgeInsets.all(10.0),
//                        child: Image(
//                          height: 40,
//                          width: 40,
//                          image: AssetImage(
//                              "lib/features/login_registration/assets/facebook.png"),
//                        )),
//                  ],
//                ),
//              ),
              const Spacer(),
              // TextButton(
              //     onPressed: () {},
              //     child: Text(
              //       "Contact Number : 1234567890",
              //       style: TextStyle(
              //         color: Colors.grey[700],
              //       ),
              //     )),
              // TextButton(
              //     onPressed: () {},
              //     child: Text(
              //       "Email : placeholder@gmail.com",
              //       style: TextStyle(
              //         color: Colors.grey[700],
              //       ),
              //     )),
              const Padding(
                padding: EdgeInsets.only(bottom: 18.0),
                child: Image(
                    color: Colors.grey,
                    height: 30,
                    width: 100,
                    image: AssetImage(
                        'lib/features/login_registration/assets/matrix.png')),
              ),
            ],
          ),
        ));
  }
}
