import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/assets.dart';

class FavouritesListView extends StatelessWidget {
  const FavouritesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) => Container(
        child: Row(
          
          children: [
            Image.asset(
              Assets.imagesClothes
            )
          ],
        ),
      ),

      itemCount: 5,
    );
  }
}