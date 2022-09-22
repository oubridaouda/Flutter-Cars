import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourth_training/model/carModel.dart';
import 'package:fourth_training/views/shared-ui/favoriteBadge.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CarFeed extends StatelessWidget {
  final Car? car;
  final String? userID;

  const CarFeed({Key? key, this.car, this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                "/detail",
                arguments: car!,
              ),
              child: Hero(
                  tag: car!.carName!,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        color: Colors.grey,
                        image: DecorationImage(
                            image: NetworkImage(car!.carUrlImg!),
                            fit: BoxFit.cover)),
                  )),
            ),
            FavoriteBadge(
              car: car,
              userID: userID,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car!.carName!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("De ${car!.carUsername}")
                ],
              ),
              Text(formattingDate(car!.carTimestamp))
            ],
          ),
        )
      ],
    );
  }

  String formattingDate(Timestamp? timestamp) {
    initializeDateFormatting("fr", null);
    DateTime? dateTime = timestamp?.toDate();
    DateFormat dateFormat = DateFormat.MMMd("fr");
    return dateFormat.format(dateTime ?? DateTime.now());
  }
}
