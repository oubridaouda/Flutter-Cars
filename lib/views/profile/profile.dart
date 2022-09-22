import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourth_training/views/profile/profileAppBar.dart';
import 'package:fourth_training/views/shared-ui/carList.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProfileAppBar(user: _user),
            SliverList(
              delegate: SliverChildListDelegate([
                const Padding(
                  padding: EdgeInsets.only(top: 24.0, left: 16.0, bottom: 12.0),
                  child: Text("Vos voiture favoris",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Divider(),
              ]),
            ),
            CarList(pageName: 'Profile', userId: _user!.uid,)
          ],
        ),
      ),
    );
  }
}
