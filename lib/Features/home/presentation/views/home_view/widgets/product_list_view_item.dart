import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/manage_favourites/manage_favourites_cubit.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

class ProductListViewItem extends StatelessWidget {
  const ProductListViewItem({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 121,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  SizedBox(
                    height: 123,
                    width: 121,
                    child: Image.network(
                      product.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  BlocConsumer<ManageFavouritesCubit, ManageFavouritesState>(
                    listener: (context, state) {
                      if(state is ManageFavouritesError){
                        snackBar(content: state.error, context: context);
                      }
                    },
                    builder: (context, state) {
                    final blocInstance= BlocProvider.of<ManageFavouritesCubit>(context);
                      return Positioned(
                        top: 5,
                        right: 5,
                        child: InkWell(
                          onTap: () {
                            if(blocInstance.isFavourite(productId: product.id)){
                              blocInstance.removeFromFavourites( product.id);
                            }
                            else{
                              blocInstance.addToFavourites(product.id);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.kItemBackgroundColor, ),
                            child: Icon(
                              blocInstance.isFavourite(productId: product.id) ?Icons.favorite: Icons.favorite_border_rounded,
                              color: blocInstance.isFavourite(productId: product.id) ?AppColors.kRed:Colors.black),
                             
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )),
          const SizedBox(
            height: 2,
          ),
          Text(
            product.name,
            style: Styles.kSmallTextStyle(context).copyWith(fontSize: 15),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  "EGP ${product.price}",
                  style:
                      Styles.kMediumTextStyle(context).copyWith(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.black,
                ),
                onPressed: () {},
                style: IconButton.styleFrom(padding: EdgeInsets.zero),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
