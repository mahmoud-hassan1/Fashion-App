import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/manage_favourites/manage_favourites_cubit.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/product_details/presentation/views/product_details_view/product_details.dart';
import 'package:online_shopping/Features/shop/presentation/views/widgets/product_item.dart';

class ProductsScreenListView extends StatelessWidget {
  const ProductsScreenListView({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return products.isNotEmpty? ListView.separated(
      itemBuilder: (context, index) => InkWell(
        onTap: () async{
           await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(product: products[index])));
            if(context.mounted){
              BlocProvider.of<ManageFavouritesCubit>(context).emitState();
            }
        },
        child: ProductItem(product: products[index])),
      itemCount: products.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16,),
    ):const Center(child: Text("No Products Yet"));
  }
}