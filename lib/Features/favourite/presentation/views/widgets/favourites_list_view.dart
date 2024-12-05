import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/manage_favourites/manage_favourites_cubit.dart';
import 'package:online_shopping/Features/favourite/presentation/views/widgets/favourites_item.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/favourites_cubit/favourites_cubit.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/assets.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';
import 'package:lottie/lottie.dart';
class FavouritesListView extends StatelessWidget {
  const FavouritesListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> products = [];
    return BlocConsumer<FavouritesCubit, FavouritesState>(
      listener: (context, state) {
        if (state is FavouritesFail) {
          snackBar(content: state.message, context: context);
        } else if (state is FavouritesSuccess) {
          products = state.products;
        }
      },
      builder: (context, state) {
        if (state is FavouritesLoading) {
          return const SliverToBoxAdapter(
              child: Center(
                  child: CircularProgressIndicator(
            color: AppColors.kRed,
          )));
        } else if (state is FavouritesSuccess) {
          return BlocConsumer<ManageFavouritesCubit, ManageFavouritesState>(
            listener: (context, state) {
              if (state is ManageFavouritesSuccess){
                products.removeWhere((product) => product.id == state.productId);
              }
            },
            builder: (context, state) {
              return products.isNotEmpty
                  ? SliverPadding(
                      padding: const EdgeInsets.only(top: 16, bottom: 32),
                      sliver: SliverList.separated(
                        itemBuilder: (context, index) =>
                            FavouritesItem(product: products[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                        itemCount: products.length,
                      ),
                    )
                  :  SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Center(child: Lottie.asset(Assets.animationsEmptyAnimation),),
                          Text(
                            "No Favourites yet",
                            style: Styles.kFontSize30(context),
                          )
                        ],
                      ),
                    );
            },
          );
        } else {
          return const SliverToBoxAdapter(
              child: Center(child: Text("Some thing went wrong")));
        }
      },
    );
  }
}
