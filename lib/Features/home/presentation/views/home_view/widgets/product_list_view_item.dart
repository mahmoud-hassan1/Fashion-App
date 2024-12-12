import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/add_product/presentation/views/edit_product_view.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/manage_favourites/manage_favourites_cubit.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/favourites_button.dart';
import 'package:online_shopping/core/models/user_model.dart';

import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

import '../../../../../product_details/presentation/views/product_details_view/product_details.dart';

class ProductListViewItem extends StatelessWidget {
  const ProductListViewItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: product),
          ),
        );

        if (context.mounted) {
          BlocProvider.of<ManageFavouritesCubit>(context).emitState();
        }
      },
      child: SizedBox(
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
                        if (state is ManageFavouritesError) {
                          snackBar(content: state.error, context: context);
                        }
                      },
                      builder: (context, state) {
                        final blocInstance =
                            BlocProvider.of<ManageFavouritesCubit>(context);
                        return Positioned(
                          top: 5,
                          right: 5,
                          child: FavouritesButton(
                              blocInstance: blocInstance, product: product),
                        );
                      },
                    ),
                    UserModel.getInstance().role == 'admin'
                        ? IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditProductView(product: product),
                                  ));
                            },
                            icon: const Icon(Icons.edit))
                        : SizedBox()
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
                    "${product.price}\$",
                    style:
                        Styles.kMediumTextStyle(context).copyWith(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
