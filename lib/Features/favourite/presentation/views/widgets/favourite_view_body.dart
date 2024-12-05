import 'package:flutter/material.dart';
import 'package:online_shopping/Features/favourite/presentation/views/widgets/favourites_list_view.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class FavouriteViewBody extends StatelessWidget {
  const FavouriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
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
            style: Styles.kLargeTextStyle(context),
            ),
          ),
          const FavouritesListView()
        ],
      ),
    );
  }
}
