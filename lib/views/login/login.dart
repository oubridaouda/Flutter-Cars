import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourth_training/services/authentification.dart';
import 'package:fourth_training/views/shared-ui/showSnackBar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool inLoginProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: const BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                    image: AssetImage("assets/fire_car.png"),
                    fit: BoxFit.cover),
              ),
            ),
            Text(
              'Fire Cars',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: Colors.black45, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Découvrez et partager les meilleurs voitures de luxes 2021",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
            ),
            inLoginProcess
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () {
                      signIn(context);
                    },
                    child: const Text("Connectez-vous avec Google"),
                  )
          ],
        ),
      )),
    );
  }

  Future signIn(BuildContext context) async{
    try{
      final result = await InternetAddress.lookup("google.com");
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        setState(() {
          inLoginProcess = true;
          AuthService().signInWithGoogle();
        });
      }
    }on SocketException catch(_){
      showNotification(context, "Aucune connexion internet");
    }
  }
}
