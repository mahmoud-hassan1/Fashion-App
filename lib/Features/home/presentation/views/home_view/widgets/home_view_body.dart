import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/presentation/cubits/newest_cubit/newest_cubit.dart';
import 'package:online_shopping/Features/home/presentation/cubits/sale_cubit/sale_cubit.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/header_titles.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/offers_list_view.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/product_list_view.dart';

// ignore: must_be_immutable
class HomeViewBody extends StatelessWidget {
  HomeViewBody({super.key});
  List<Product> products = [
    Product(categories: ["Sale"], id: "1", name: "evening dress", price: 200, image: "assets/images/item.png", description: "Dummy description", rate: 4.5, sellerId: "dummySellerId", stock: 10, subtitle: "Short Dress"),
    Product(categories: ["Sale"], id: "1", name: "evening dress", price: 200, image: "assets/images/item.png", description: "Dummy description", rate: 4.5, sellerId: "dummySellerId", stock: 10, subtitle: "Short Dress"),
    Product(categories: ["Sale"], id: "1", name: "evening dress", price: 200, image: "assets/images/item.png", description: "Dummy description", rate: 4.5, sellerId: "dummySellerId", stock: 10, subtitle: "Short Dress"),
    Product(categories: ["Sale"], id: "1", name: "evening dress", price: 200, image: "assets/images/item.png", description: "Dummy description", rate: 4.5, sellerId: "dummySellerId", stock: 10, subtitle: "Short Dress"),
  ];
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const OffersListView(),
          const Header(
            title: "New",
          ),
          const SizedBox(
            height: 16,
          ),
          BlocBuilder<NewestCubit, NewestState>(
            builder: (context, state) {
              if (state is NewestSuccess) {
                return ProductListView(products: state.products);
              } else if (state is NewestFail) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const Header(
            title: "Sales",
          ),
          const SizedBox(
            height: 16,
          ),
          BlocBuilder<SaleCubit, SaleState>(
            builder: (context, state) {
              if (state is SaleSuccess) {
                return ProductListView(products: state.products);
              } else if (state is SaleFailed) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
