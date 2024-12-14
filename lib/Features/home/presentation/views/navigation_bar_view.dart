import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/product_management/presentation/views/add_product_view.dart';
import 'package:online_shopping/Features/bag/data/repo_impl/my_bag_repo_impl.dart';
import 'package:online_shopping/Features/bag/presentation/cubits/my_bag_cubit/my_bag_cubit.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/get_favourites_poducts.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/favourites_cubit/favourites_cubit.dart';
import 'package:online_shopping/Features/home/domain/use_cases/get_newest_products.dart';
import 'package:online_shopping/Features/home/domain/use_cases/get_sale_products.dart';
import 'package:online_shopping/Features/home/presentation/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:online_shopping/Features/home/presentation/cubits/newest_cubit/newest_cubit.dart';
import 'package:online_shopping/Features/home/presentation/cubits/sale_cubit/sale_cubit.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/home_view.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/di.dart';
import 'package:online_shopping/features/shop/presentation/views/shop_view.dart';
import 'package:online_shopping/features/bag/presentation/views/my_bag_view.dart';
import 'package:online_shopping/features/favourite/presentation/views/favourite_view.dart';
import 'package:online_shopping/features/profile/presentation/views/profile_view.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';

class NavigationBarView extends StatelessWidget {
  const NavigationBarView({super.key});

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    ShopView(),
    const MyBagView(),
    const FavouriteView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (_) => NavigationCubit(),
        ),
        BlocProvider<SaleCubit>(
          create: (BuildContext context) => SaleCubit(getIt<GetSaleProducts>())..getProductsOnSale(),
        ),
        BlocProvider<NewestCubit>(
          create: (BuildContext context) => NewestCubit(getIt<GetNewestProducts>())..getNewestProductsOnSale(),
        ),
        BlocProvider<FavouritesCubit>(
          create: (context) => FavouritesCubit(getIt<GetFavouritesPoductsUseCase>()),
        ),
        BlocProvider<MyBagCubit>(
          create: (context) => MyBagCubit(getIt<MyBagRepoImpl>()),
        ),
      ],
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) => Scaffold(
          body: PageView(
            controller: pageController,
            onPageChanged: (index) {
              context.read<NavigationCubit>().selectTab(index);
            },
            children: _widgetOptions,
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              selectedItemColor: AppColors.kRed,
              selectedIconTheme: const IconThemeData(size: 30), // Bigger icons
              unselectedIconTheme: const IconThemeData(size: 25), // Bigger icons
              selectedLabelStyle: const TextStyle(fontSize: 12), // Smaller labels
              unselectedLabelStyle: const TextStyle(fontSize: 10), // Smaller labels
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Shop'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Bag'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Favourite'),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
              ],
              currentIndex: state.index,
              onTap: (index) {
                context.read<NavigationCubit>().selectTab(index);
                pageController.jumpToPage(index); // Update PageView
              },
            ),
          ),
          floatingActionButton: UserModel.getInstance().role == Role.admin
              ? FloatingActionButton(
                  backgroundColor: const Color(0xffdb3022),
                  child: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddProductView(),
                      ),
                    );
                  },
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
