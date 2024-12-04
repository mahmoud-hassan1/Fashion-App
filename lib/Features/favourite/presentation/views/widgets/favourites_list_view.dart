import 'package:flutter/material.dart';
import 'package:online_shopping/Features/favourite/presentation/views/widgets/favourites_item.dart';


class FavouritesListView extends StatelessWidget {
  const FavouritesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top:16,bottom: 32),
      sliver: SliverList.separated(
        
        itemBuilder: (context, index) => const FavouritesItem(),
        separatorBuilder: (context, index) => const SizedBox(
          height: 24,
        ),
        itemCount: 5,
      ),
    );
  }
}

