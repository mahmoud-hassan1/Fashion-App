import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/bag/data/repo_impl/bag_repo_impl.dart';
import 'package:online_shopping/Features/bag/presentation/cubits/my_bag_cubit/my_bag_cubit.dart';
import 'package:online_shopping/Features/favourite/data/repo_impl/favourite_repo_impl.dart';
import 'package:online_shopping/Features/favourite/domain/repo_interface/favourite_repo.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/get_favourites_poducts.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/favourites_cubit/favourites_cubit.dart';
import 'package:online_shopping/Features/home/data/repo_impl/home_repo_impl.dart';
import 'package:online_shopping/Features/home/domain/repo_interface/home_repo.dart';
import 'package:online_shopping/Features/home/domain/use_cases/get_newest_products.dart';
import 'package:online_shopping/Features/home/domain/use_cases/get_sale_products.dart';
import 'package:online_shopping/Features/home/presentation/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:online_shopping/Features/home/presentation/cubits/newest_cubit/newest_cubit.dart';
import 'package:online_shopping/Features/home/presentation/cubits/sale_cubit/sale_cubit.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/home_view.dart';
import 'package:online_shopping/features/shop/presentation/views/shop_view.dart';
import 'package:online_shopping/features/bag/presentation/views/bag_view.dart';
import 'package:online_shopping/features/favourite/presentation/views/favourite_view.dart';
import 'package:online_shopping/features/profile/presentation/views/profile_view.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';

class NavigationBarView extends StatelessWidget {
  const NavigationBarView({super.key});

  static  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
     ShopView(),
    const BagView(),
    const FavouriteView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final HomeRepo homeRepo = HomeRepoImpl(firestore: FirebaseFirestore.instance);
    final GetSaleProducts getSaleProducts = GetSaleProducts(homeRepo);
    final GetNewestProducts getNewestProducts = GetNewestProducts(homeRepo);
    final PageController pageController = PageController();
    final FavouriteRepo favouriteRepo = FavouriteRepoImpl(firestore: FirebaseFirestore.instance);
    final GetFavouritesPoductsUseCase getFavouritesPoducts = GetFavouritesPoductsUseCase(favouriteRepo);

    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (_) => NavigationCubit(),
        ),
        BlocProvider<SaleCubit>(
          create: (BuildContext context) => SaleCubit(getSaleProducts: getSaleProducts)..getProductsOnSale(),
        ),
        BlocProvider<NewestCubit>(
          create: (BuildContext context) => NewestCubit(getNewestProducts: getNewestProducts)..getNewestProductsOnSale(),
        ),
        BlocProvider<FavouritesCubit>(
          create: (context) => FavouritesCubit(getFavouritesPoductsUseCase: getFavouritesPoducts),
        ),
     
        BlocProvider<MyBagCubit>(
          create: (context) => MyBagCubit(repo: BagRepoImpl(FavouriteRepoImpl(firestore: FirebaseFirestore.instance))),
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
          floatingActionButton:  FloatingActionButton(onPressed: (){
            
          }),
        ),
      ),
    );
  }
}
