import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourth_training/views/home/addCarSection.dart';
import 'package:fourth_training/views/home/homeAppBar.dart';
import 'package:fourth_training/views/shared-ui/carList.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? _user = Provider.of<User>(context);
    return  Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            HomeAppBar(user: _user),
            AddCarSection(user: _user),
            CarList(userId: _user?.uid,)
          ],
        ),
      ),
    );
  }
}
