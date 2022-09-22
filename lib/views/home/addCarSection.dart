import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourth_training/views/home/showCarDialog.dart';
import 'package:fourth_training/views/shared-ui/showSnackBar.dart';
import 'package:image_picker/image_picker.dart';

class AddCarSection extends StatefulWidget {
  final User? user;
  const AddCarSection({Key? key, this.user}) : super(key: key);

  @override
  State<AddCarSection> createState() => _AddCarSectionState();
}

class _AddCarSectionState extends State<AddCarSection> {

  initSearchBar(String searchText){

  }
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[300]),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                    child: IconButton(
                      onPressed: () =>showCardDialog(context,widget.user!),
                      icon: const Icon(Icons.add),
                    ),
                  )
                ],
              )
            ],
          ))
    ]));
  }

  Future showCardDialog(BuildContext context, User user) async{
    try{
      final result = await InternetAddress.lookup("google.com");
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        CarDialog(user: user).showCardDialog(context, ImageSource.gallery);

      }
    }on SocketException catch(_){
      showNotification(context, "Aucune connexion internet");
    }
  }
}
