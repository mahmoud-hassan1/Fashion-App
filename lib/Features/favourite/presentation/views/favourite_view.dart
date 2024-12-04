import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/favourites_cubit/favourites_cubit.dart';
import 'package:online_shopping/Features/favourite/presentation/views/widgets/favourite_view_body.dart';
import 'package:online_shopping/core/models/user_model.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    print(UserModel.getInstance().toString());
    BlocProvider.of<FavouritesCubit>(context).getFavouritesProducts();
    return const Scaffold(
      body: FavouriteViewBody(),
    );
  }
}
