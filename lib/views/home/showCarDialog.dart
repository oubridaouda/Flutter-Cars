import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourth_training/model/carModel.dart';
import 'package:fourth_training/services/dbServices.dart';
import 'package:fourth_training/views/shared-ui/showSnackBar.dart';
import 'package:image_picker/image_picker.dart';

class CarDialog {
  User? user;

  CarDialog({this.user});

  //pour la boite de dialog
  void showCardDialog(BuildContext context, ImageSource source) async {
    final _keyForm = GlobalKey<FormState>();
    String _carName = "";
    String _formError = "Veillez fournir le nom de la voiture svp!";
    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickedFile!.path);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  color: Colors.grey,
                  image: DecorationImage(
                    image: FileImage(_file),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Form(
                        key: _keyForm,
                        child: TextFormField(
                          maxLength: 20,
                          onChanged: (value) => _carName = value,
                          validator: (value) =>
                              _carName == "" ? _formError : null,
                          decoration: const InputDecoration(
                              labelText: "Nom de la voiture",
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                          child: Wrap(

                        children: [
                          TextButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text("Annuler"),
                          ),
                          ElevatedButton(
                            onPressed: () =>onSubmit(context, _keyForm,_file,_carName,user),
                            child: Text('Publier'),
                          )
                        ],
                      ))
                    ],
                  ))
            ],
          );
        });
  }

  void onSubmit(context, keyForm, file, carName,user) async{
    if(keyForm.currentState!.validate()){
      Navigator.of(context).pop();
      showNotification(context, "Chargement...");
      DatabaseService db = DatabaseService();
      String carUrlImg = await db.uploadFile(file);
      db.addCar(Car(
        carName: carName,
        carUrlImg: carUrlImg,
        carUserId: user!.uid,
        carUsername: user!.displayName
      ));
    }
  }

}

