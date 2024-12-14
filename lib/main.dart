import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/Features/bag/data/repo_impl/my_bag_repo_impl.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/add_to_favourites.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/remove_from_favourites.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/manage_favourites/manage_favourites_cubit.dart';
import 'package:online_shopping/Features/product_details/presentation/cubits/product_details_cubit/product_details_cubit.dart';
import 'package:online_shopping/Features/reviews/data/repo_impl/product_reviews_repo_impl.dart';
import 'package:online_shopping/Features/reviews/presentation/cubits/product_reviews_cubit/product_reviews_cubit.dart';
import 'package:online_shopping/Features/shop/domain/use_cases/get_newest_products_by_cat.dart';
import 'package:online_shopping/Features/shop/domain/use_cases/get_products_by_cat.dart';
import 'package:online_shopping/Features/shop/domain/use_cases/get_sale_products_by_cat.dart';
import 'package:online_shopping/Features/shop/presentation/manger/cubit/shop_cubit.dart';
import 'package:online_shopping/Features/splash/presentation/views/splash_view.dart';
import 'package:online_shopping/core/utiles/di.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setup();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ShopCubit>(
            create: (context) => ShopCubit(
              getSaleProductsByCategory: getIt<GetSaleProductsByCategory>(),
              getNewestProductsByCategory: getIt<GetNewestProductsByCategory>(),
              getProductsByCategory: getIt<GetProductsByCategory>(),
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => ProductReviewsCubit(getIt<ProductReviewsRepoImpl>()),
          ),
          BlocProvider(
            create: (context) => ProductDetailsCubit(
              getIt<MyBagRepoImpl>(),
              getIt<ProductReviewsRepoImpl>(),
            ),
          ),
          BlocProvider(
            create: (context) => ManageFavouritesCubit(
              getIt<AddToFavouritesUseCase>(),
              getIt<RemoveFromFavouritesUseCase>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Online Shopping',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: AppColors.kBackgroundColor,
            appBarTheme: const AppBarTheme(
              color: AppColors.kBackgroundColor,
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
          ),
          home: const SplashView(),
        ),
      ),
    );
  }
}
