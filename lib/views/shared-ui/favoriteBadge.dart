import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourth_training/model/carModel.dart';
import 'package:fourth_training/services/dbServices.dart';

class FavoriteBadge extends StatefulWidget {
  final Car? car;
  final String? userID;

  const FavoriteBadge({Key? key, this.car, this.userID}) : super(key: key);

  @override
  State<FavoriteBadge> createState() => _FavoriteBadgeState();
}

class _FavoriteBadgeState extends State<FavoriteBadge> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 4.0,
      right: 12.0,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: const BorderRadius.all(Radius.circular(8.0))),
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: widget.car!.isMyFavoriteCar!
            ? GestureDetector(
                onTap: () => DatabaseService()
                    .removeFavoriteCar(widget.car!, widget.userID!),
                child: Row(
                  children: [
                    Text(
                      "${widget.car!.carFavoriteCount}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  ],
                ))
            : GestureDetector(
                onTap: () =>
                    DatabaseService().addFavorite(widget.car!, widget.userID!),
                child: Row(
                  children: [
                    widget.car!.carFavoriteCount! > 0
                        ? Text(
                            "${widget.car!.carFavoriteCount}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          )
                        : Container(),
                    const Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
