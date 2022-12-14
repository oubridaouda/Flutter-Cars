import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fourth_training/model/carModel.dart';
import 'package:fourth_training/services/dbServices.dart';
import 'package:fourth_training/views/shared-ui/showSnackBar.dart';
import 'package:provider/provider.dart';

class CarDetail extends StatelessWidget {
  const CarDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context)!.settings.arguments as Car;
    final _userID = Provider.of<User?>(context)!.uid;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          car.carName!,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        actions: [
          car.carUserId == _userID
              ? IconButton(
                  onPressed: () => onDeleteCar(context, car),
                  icon: const Icon(Icons.delete))
              : Container()
        ],
      ),
      body: InteractiveViewer(
          child: Hero(
              tag: car.carName!,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: NetworkImage(car.carUrlImg!),
                      )),
                ),
              ))),
    );
  }

  void onDeleteCar(BuildContext context, Car car) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Voulez-vous supprimer votre ${car.carName} ?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Annuler'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  DatabaseService().deleteCar(car.carId);
                  showNotification(context, "Supprimer avec succ??s");
                },
                child: Text("Supprimer"),
              )
            ],
          );
        });
  }
}
