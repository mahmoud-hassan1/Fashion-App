import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/favourites_cubit/favourites_cubit.dart';
import 'package:online_shopping/Features/favourite/presentation/views/widgets/favourite_view_body.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavouritesCubit>(context).getFavouritesProducts();
    return const Scaffold(
      body: FavouriteViewBody(),
    );
  }
}
