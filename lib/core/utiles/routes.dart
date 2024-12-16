import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/auth/domain/repo_interface/auth_repo.dart';
import 'package:online_shopping/Features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:online_shopping/Features/auth/presentation/views/login_view/login_view.dart';
import 'package:online_shopping/Features/auth/presentation/views/reset_password_view/reset_password_view.dart';
import 'package:online_shopping/Features/auth/presentation/views/signup_view/signup_view.dart';
import 'package:online_shopping/Features/auth/presentation/views/signup_view/widgets/complete_google_signup_process.dart';
import 'package:online_shopping/Features/bag/data/repo_impl/my_bag_repo_impl.dart';
import 'package:online_shopping/Features/bag/presentation/cubits/my_bag_cubit/my_bag_cubit.dart';
import 'package:online_shopping/Features/bag/presentation/cubits/order_review_cubit/order_review_cubit.dart';
import 'package:online_shopping/Features/bag/presentation/views/widgets/order_review_view.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/get_favourites_poducts.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/favourites_cubit/favourites_cubit.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/domain/use_cases/get_newest_products.dart';
import 'package:online_shopping/Features/home/domain/use_cases/get_sale_products.dart';
import 'package:online_shopping/Features/home/presentation/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:online_shopping/Features/home/presentation/cubits/newest_cubit/newest_cubit.dart';
import 'package:online_shopping/Features/home/presentation/cubits/sale_cubit/sale_cubit.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/home_view.dart';
import 'package:online_shopping/Features/home/presentation/views/navigation_bar_view.dart';
import 'package:online_shopping/Features/product_details/presentation/views/product_details_view/product_details.dart';
import 'package:online_shopping/Features/product_management/presentation/views/add_product_view.dart';
import 'package:online_shopping/Features/product_management/presentation/views/edit_product_view.dart';
import 'package:online_shopping/Features/reviews/presentation/views/product_reviews_view.dart';
import 'package:online_shopping/Features/search/data/repo_impl/search_repo_impl.dart';
import 'package:online_shopping/Features/search/data/repo_impl/speech_to_text_repo_impl.dart';
import 'package:online_shopping/Features/search/presentation/manger/qr_code_scanning_cubit/qr_code_scanning_cubit.dart';
import 'package:online_shopping/Features/search/presentation/manger/search_cubit/search_cubit.dart';
import 'package:online_shopping/Features/search/presentation/manger/speech_to_text_cubit/speech_to_text_cubit.dart';
import 'package:online_shopping/Features/search/presentation/views/search_view.dart';
import 'package:online_shopping/Features/shop/presentation/views/products_screen.dart';
import 'package:online_shopping/Features/splash/presentation/views/splash_view.dart';
import 'package:online_shopping/core/utiles/di.dart';
import 'package:online_shopping/features/bag/presentation/views/my_bag_view.dart';
import 'package:online_shopping/features/favourite/presentation/views/favourite_view.dart';
import 'package:online_shopping/features/profile/presentation/views/profile_view.dart';
import 'package:online_shopping/features/shop/presentation/views/shop_view.dart';

abstract class AppRouter {
  static final Widget loginView = BlocProvider(
    create: (context) => AuthCubit(getIt<AuthRepo>()),
    child: const LoginView(),
  );

  static final Widget resetPasswordView = BlocProvider(
    create: (context) => AuthCubit(getIt<AuthRepo>()),
    child: const ResetPasswordView(),
  );

  static final Widget signupView = BlocProvider(
    create: (context) => AuthCubit(getIt<AuthRepo>()),
    child: const SignupView(),
  );

  static Widget completeGoogleSignupProcessView(OAuthCredential oAuthCredential) => BlocProvider(
        create: (context) => AuthCubit(getIt<AuthRepo>()),
        child: CompleteGoogleSignupProcess(oAuthCredential: oAuthCredential),
      );

  static const Widget myBagView = MyBagView();

  static const Widget favouriteView = FavouriteView();

  static const Widget homeView = HomeView();

  static const Widget addProductView = AddProductView();

  static Widget orderReviewCubit = BlocProvider(
    create: (context) => OrderReviewCubit(getIt<MyBagRepoImpl>()),
    child: OrderReviewView(),
  );

  static final Widget searchView = MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SearchCubit(getIt<SearchRepoImpl>(), getIt<SpeechToTextRepoImpl>()),
      ),
      BlocProvider(
        create: (context) => QrCodeScanningCubit(getIt<SearchRepoImpl>()),
      ),
      BlocProvider(
        create: (context) => SpeechToTextCubit(getIt<SpeechToTextRepoImpl>()),
      ),
    ],
    child: const SearchView(),
  );

  static const Widget shopView = ShopView();

  static const Widget splashView = SplashView();

  static const Widget profileView = ProfileView();

  static Widget productsScreen(String title, List<Product>? products) => ProductsScreen(title: title, products: products);

  static Widget productDetailsView(Product product) => ProductDetails(product: product);

  static Widget editProductView(Product product) => EditProductView(product: product);

  static Widget productReviewsView(Product product) => ProductReviewsView(product: product);

  static Widget navigationBarView = MultiBlocProvider(
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
    child: const NavigationBarView(),
  );
}
