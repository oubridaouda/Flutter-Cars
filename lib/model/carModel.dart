import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  String? carId,carUserId, carName, carUrlImg, carUsername;
  Timestamp? carTimestamp;
  bool? isMyFavoriteCar;
  int? carFavoriteCount;

  Car({
    this.carId,
    this.carName,
    this.carUserId,
    this.carUrlImg,
    this.carUsername,
    this.carTimestamp,
    this.isMyFavoriteCar,
    this.carFavoriteCount,
  });

}
