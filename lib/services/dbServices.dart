import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fourth_training/model/carModel.dart';

class DatabaseService {
  String? userID, carID;
  DatabaseService({this.userID, this.carID});
  CollectionReference _cars = FirebaseFirestore.instance.collection("cars");
  FirebaseStorage _storage = FirebaseStorage.instance;

  //function upload image
  Future<String> uploadFile(file) async {
    Reference reference = _storage.ref().child("cars/${DateTime.now()}.png");
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  //ajout de la voiture dans la BD

  void addCar(Car car) {
    _cars.add({
      "carName": car.carName,
      "carUrlImg": car.carUrlImg,
      "carUserId": car.carUserId,
      "carUserName": car.carUsername,
      "Timestamp": FieldValue.serverTimestamp(),
      "carFavoriteCount": 0
    });
  }

  //récuperation de toutes les voiture en récupere
  Stream<List<Car>> get cars{
    Query queryCars = _cars.where("carName",isGreaterThanOrEqualTo: "Honda");
    return queryCars.snapshots().map((snapshot){
      return snapshot.docs.map((docs){
        return Car(
          carId: docs.id,
          carUrlImg: docs.get("carUrlImg"),
          carUserId: docs.get("carUserId"),
          carName: docs.get("carName"),
          carUsername: docs.get("carUserName"),
          carFavoriteCount: docs.get("carFavoriteCount"),
          carTimestamp: docs.get("Timestamp"),
        );
      }).toList();
    });
  }

  //récuperation de toutes les voiture en récupere
  Stream<List<Car>> get searchCars{
    Query queryCars = _cars.where("carName",isEqualTo: "Luxe").orderBy("Timestamp",descending: true);
    return queryCars.snapshots().map((snapshot){
      return snapshot.docs.map((docs){
        return Car(
          carId: docs.id,
          carUrlImg: docs.get("carUrlImg"),
          carUserId: docs.get("carUserId"),
          carName: docs.get("carName"),
          carUsername: docs.get("carUserName"),
          carFavoriteCount: docs.get("carFavoriteCount"),
          carTimestamp: docs.get("Timestamp"),
        );
      }).toList();
    });
  }

  //Ajout de la voiture favoris dans une sous-collection
  void addFavorite(Car car, String userID)async{
    final carDocRef = _cars.doc(car.carId);
    final favoriteBy = carDocRef.collection("favoriteBy");
    int carFavoriteCount = car.carFavoriteCount!;
    int increaseCount = carFavoriteCount +=1;
    favoriteBy.doc(userID).set({
      "carName": car.carName,
      "carUrlImg": car.carUrlImg,
      "carUserID": car.carUserId,
      "carUserName": car.carUsername,
      "carTimestamp": FieldValue.serverTimestamp(),
      "carFavoriteCount": increaseCount,
    });
    carDocRef.update({"carFavoriteCount": increaseCount});
  }

  //retirer la voiture de la liste des favoris
  void removeFavoriteCar(Car car, String userID){
    final carDocRef = _cars.doc(car.carId);
    final favoriteBy =  carDocRef.collection("favoriteBy");
    int carFavoriteCount = car.carFavoriteCount!;
    int decreaseCount = carFavoriteCount -= 1;
    carDocRef.update({
      "carFavoriteCount": decreaseCount
    });
    favoriteBy.doc(userID).delete();
  }

  // récuperation des voitures favoris de l'utilisateur en temps réel
  Stream<Car> get myFavoriteCar{
    final favoriteBy = _cars.doc(carID).collection("favoriteBy");
    return favoriteBy.doc(userID).snapshots().map((doc) {
      return Car(
        carId: doc.id,
        carUrlImg: doc.get("carUrlImg"),
        carUserId: doc.get("carUserId"),
        carName: doc.get("carName"),
        carUsername: doc.get("carUserName"),
        carFavoriteCount: doc.get("carFavoriteCount"),
        carTimestamp: doc.get("Timestamp"),
      );
    });
  }

  //Suppression d'une voiture
  Future<void> deleteCar( String? carID) => _cars.doc(carID).delete();

}
