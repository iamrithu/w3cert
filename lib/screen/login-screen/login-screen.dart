// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:w3cert/api/api.dart';
import 'package:w3cert/provider/provider.dart';
import 'package:w3cert/router/route-const.dart';

class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool visible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    authendication(String email, String password) {
      setState(() {
        visible = !visible;
      });
      API().authendication(email, password).then((value) {
        if (value.statusCode != 200) {
          setState(() {
            visible = !visible;
          });
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: '${value.data["error"]["message"]}',
          );
          return null;
        }
        setState(() {
          visible = !visible;
        });
        ref
            .read(tokenProvider.notifier)
            .update((state) => value.data["data"]["token"]);

        ref.read(loggedInProvider.notifier).state = true;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: width,
        height: height,
        color: Color.fromARGB(144, 27, 24, 73),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: width * 0.9,
                  height: height * 0.38,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: height * 0.02),
                                child: Text(
                                  "W3CERT",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Color.fromARGB(255, 27, 24, 73),
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Sing In",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: width * 0.8,
                            height: height * 0.095,
                            child: TextFormField(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email Address',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            width: width * 0.8,
                            height: height * 0.095,
                            child: TextFormField(
                              controller: _password,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }

                                return null;
                              },
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(width * 0.8, height * 0.05)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                authendication(_email.text, _password.text);
                              }
                            },
                            child: Container(
                              width: width * 0.2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Log In'),
                                  Icon(Icons.arrow_circle_right_outlined)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: visible,
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.38,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Card(
                      color: Color.fromARGB(119, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: LoadingAnimationWidget.newtonCradle(
                            color: Color.fromARGB(255, 27, 24, 73),
                            size: width * 0.2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
