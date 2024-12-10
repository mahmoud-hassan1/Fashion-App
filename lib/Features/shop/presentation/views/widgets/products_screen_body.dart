import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/shop/presentation/manger/cubit/shop_cubit.dart';
import 'package:online_shopping/Features/shop/presentation/views/widgets/products_screen_list_view.dart';

class ProductsScreenBody extends StatelessWidget {
  const ProductsScreenBody({super.key, this.products});
  final List<Product>?products;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: products==null? BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          if(state is ShopLoadedState){
          return  ProductsScreenListView(products: state.products);
          }
          else if (state is ShopLoadingState){
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is ShopErrorState){
            return Center(child: Text(state.message));
          }
          else{
            return const Center(child: Text("SomeThing went Wrong"));
          }
        },
      ): ProductsScreenListView(products: products!)
          );
  }
}

