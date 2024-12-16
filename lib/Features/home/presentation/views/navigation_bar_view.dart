import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/home/presentation/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/routes.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';

class NavigationBarView extends StatelessWidget {
  const NavigationBarView({super.key});

  static final List<Widget> _widgetOptions = <Widget>[
    AppRouter.homeView,
    AppRouter.shopView,
    AppRouter.myBagView,
    AppRouter.favouriteView,
    AppRouter.profileView,
  ];

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocBuilder<NavigationCubit, NavigationState>(
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
                      builder: (context) => AppRouter.addProductView,
                    ),
                  );
                },
              )
            : const SizedBox(),
      ),
    );
  }
}
