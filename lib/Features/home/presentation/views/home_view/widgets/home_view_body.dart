import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/home/presentation/cubits/newest_cubit/newest_cubit.dart';
import 'package:online_shopping/Features/home/presentation/cubits/sale_cubit/sale_cubit.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/header_titles.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/offers_list_view.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/product_list_view.dart';

// ignore: must_be_immutable
class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const OffersListView(),
          
          BlocBuilder<NewestCubit, NewestState>(
            builder: (context, state) {
              if (state is NewestSuccess) {
                return ProductListView(products: state.products,title: "New",);
              } else if (state is NewestFail) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        
          BlocBuilder<SaleCubit, SaleState>(
            builder: (context, state) {
              if (state is SaleSuccess) {
                return ProductListView(products: state.products,title: "Sales",);
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
