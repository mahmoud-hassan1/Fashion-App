import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class FavouriteViewBody extends StatelessWidget {
  const FavouriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
      slivers: [
        SliverAppBar(
          actions:  [
            IconButton(
              onPressed: (){},
              icon: const Icon(Icons.search),)
          ],
        ),
        SliverToBoxAdapter(
          child: Text("Favourites",
          style: Styles.kFontSize30(context),
          ),
        ),
        
      ],
    );
  }
}
