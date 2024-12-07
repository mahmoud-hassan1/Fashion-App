import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/Features/bag/data/repo_impl/bag_repo_impl.dart';
import 'package:online_shopping/Features/favourite/data/repo_impl/favourite_repo_impl.dart';
import 'package:online_shopping/Features/product/presentation/cubits/product_details_cubit/product_details_cubit.dart';
import 'package:online_shopping/Features/reviews/data/repo_impl/product_reviews_repo_impl.dart';
import 'package:online_shopping/Features/reviews/presentation/cubits/product_reviews_cubit/product_reviews_cubit.dart';
import 'package:online_shopping/Features/splash/presentation/views/splash_view.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
          BlocProvider(
            create: (BuildContext context) => ProductReviewsCubit(ProductReviewsRepoImpl()),
          ),
          BlocProvider(
            create: (context) => ProductDetailsCubit(
              BagRepoImpl(FavouriteRepoImpl(firestore: FirebaseFirestore.instance)),
              ProductReviewsRepoImpl(),
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
