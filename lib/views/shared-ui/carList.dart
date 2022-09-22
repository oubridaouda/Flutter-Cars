import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourth_training/model/carModel.dart';
import 'package:fourth_training/services/dbServices.dart';
import 'package:fourth_training/views/home/homeAppBar.dart';
import 'package:fourth_training/views/shared-ui/carFeed.dart';
import 'package:provider/provider.dart';

class CarList extends StatelessWidget {
  final String? pageName, userId;
  const CarList({Key? key, this.userId,this.pageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cars = Provider.of<List<Car>>(context);
    print("user id $_cars");
    return SliverList(
      delegate: SliverChildBuilderDelegate((_, index){
        return StreamBuilder(
          stream: DatabaseService(userID: userId,carID: _cars[index].carId).myFavoriteCar,
        builder: (context, snapshot){
          if(pageName == "Profile"){
            if(snapshot.hasData) return Container();
            _cars[index].isMyFavoriteCar = true;
            return CarFeed(car: _cars[index],userID: userId,);
          }
          if(!snapshot.hasData){
            print("Not data snapshot: ${snapshot.hasData}");
            print("has not data: ${_cars[index].isMyFavoriteCar}");
            _cars[index].isMyFavoriteCar = false;
              return CarFeed(car: _cars[index], userID: userId);
            }else{
            print("has data: ${_cars[index].isMyFavoriteCar}");
            _cars[index].isMyFavoriteCar = true;
              return CarFeed(car: _cars[index], userID: userId);
            }
        },
        );
      },
        childCount: _cars.length,
      ),
    );
  }
}
