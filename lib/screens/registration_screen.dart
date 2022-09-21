import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/extra_widgets.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  String email;
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/beta_fish.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  username = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your username',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                  )),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RoundedButton(
                    color: Colors.blueAccent,
                    text: 'Register',
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final FirebaseUser user = await _auth.currentUser();
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email.trim(), password: password.trim());

                        if (newUser != null) {
                          // _firestore
                          //     .collection('users')
                          //     .document(user.uid)
                          //     .setData({
                          //   'id': user.uid,
                          //   'nickname': user.displayName,
                          // });
                          Navigator.pushNamed(context, ChatScreen.id);
                        }

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
