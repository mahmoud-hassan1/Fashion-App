import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/manage_favourites/manage_favourites_cubit.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/shop/presentation/views/widgets/product_item.dart';
import 'package:online_shopping/core/utiles/routes.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class ProductsScreenListView extends StatelessWidget {
  const ProductsScreenListView({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return products.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => AppRouter.productDetailsView(products[index])));
                  if (context.mounted) {
                    BlocProvider.of<ManageFavouritesCubit>(context).emitState();
                  }
                },
                child: ProductItem(product: products[index])),
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
          )
        : Center(
            child: Text(
              "No Products Yet",
              style: Styles.kMediumTextStyle(context).copyWith(fontSize: 34),
            ),
          );
  }
}
