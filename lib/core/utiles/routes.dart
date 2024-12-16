import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/auth/presentation/views/login_view/login_view.dart';
import 'package:online_shopping/Features/auth/presentation/views/reset_password_view/reset_password_view.dart';
import 'package:online_shopping/Features/auth/presentation/views/signup_view/signup_view.dart';
import 'package:online_shopping/Features/auth/presentation/views/signup_view/widgets/complete_google_signup_process.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/home_view.dart';
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
  static const Widget loginView = LoginView();

  static const Widget resetPasswordView = ResetPasswordView();

  static const Widget signupView = SignupView();

  static const Widget myBagView = MyBagView();

  static const Widget favouriteView = FavouriteView();

  static const Widget homeView = HomeView();

  static const Widget addProductView = AddProductView();

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

  static Widget completeGoogleSignupProcessView(OAuthCredential oAuthCredential) => CompleteGoogleSignupProcess(oAuthCredential: oAuthCredential);

  static Widget productDetailsView(Product product) => ProductDetails(product: product);

  static Widget editProductView(Product product) => EditProductView(product: product);

  static Widget productReviewsView(Product product) => ProductReviewsView(product: product);
}
