import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/auth/data/repo_impl/auth_repo_imp.dart';
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
import 'package:online_shopping/Features/favourite/presentation/cubits/add_to_cart_cubit/add_to_cart_cubit.dart';
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
import 'package:online_shopping/Features/product_management/domain/usecases/delete_product_usecase.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/edit_product_usecase.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/upload_product_usecase.dart';
import 'package:online_shopping/Features/product_management/presentation/manger/manage_products/manage_products_cubit.dart';
import 'package:online_shopping/Features/product_management/presentation/views/add_product_view.dart';
import 'package:online_shopping/Features/product_management/presentation/views/edit_product_view.dart';
import 'package:online_shopping/Features/profile/data/repo_impl/profile_repo_impl.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/my_orders_cubit/my_orders_cubit.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/my_profile_cubit/my_profile_cubit.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/product_statistics_cubit/products_statistics_cubit.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/profile_image_cubit/profile_image_cubit.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/settings_cubit/settings_cubit.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/my_orders_view.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/products_statistics.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/settings_view.dart';
import 'package:online_shopping/Features/reviews/presentation/views/product_reviews_view.dart';
import 'package:online_shopping/Features/search/data/repo_impl/search_repo_impl.dart';
import 'package:online_shopping/Features/search/data/repo_impl/speech_to_text_repo_impl.dart';
import 'package:online_shopping/Features/search/presentation/manger/qr_code_scanning_cubit/qr_code_scanning_cubit.dart';
import 'package:online_shopping/Features/search/presentation/manger/search_cubit/search_cubit.dart';
import 'package:online_shopping/Features/search/presentation/manger/speech_to_text_cubit/speech_to_text_cubit.dart';
import 'package:online_shopping/Features/search/presentation/views/search_view.dart';
import 'package:online_shopping/Features/shop/presentation/views/products_screen.dart';
import 'package:online_shopping/Features/splash/domain/use_cases/get_user_data.dart';
import 'package:online_shopping/Features/splash/presentation/cubits/cubit/user_cubit.dart';
import 'package:online_shopping/Features/splash/presentation/views/splash_view.dart';
import 'package:online_shopping/core/utiles/di.dart';
import 'package:online_shopping/features/bag/presentation/views/my_bag_view.dart';
import 'package:online_shopping/features/favourite/presentation/views/favourite_view.dart';
import 'package:online_shopping/features/profile/presentation/views/profile_view.dart';
import 'package:online_shopping/features/shop/presentation/views/shop_view.dart';

abstract class AppRouter {
  static const Widget myBagView = MyBagView();
  static const Widget homeView = HomeView();
  static const Widget addProductView = AddProductView();
  static const Widget shopView = ShopView();
  static Widget productDetailsView(Product product) => ProductDetails(product: product);
  static Widget productReviewsView(Product product) => ProductReviewsView(product: product);
  static Widget productsScreen(String title, List<Product>? products) => ProductsScreen(title: title, products: products);

  static final Widget loginView = BlocProvider<AuthCubit>(
    create: (context) => AuthCubit(getIt<AuthRepoImpl>()),
    child: const LoginView(),
  );

  static final Widget resetPasswordView = BlocProvider<AuthCubit>(
    create: (context) => AuthCubit(getIt<AuthRepoImpl>()),
    child: const ResetPasswordView(),
  );

  static final Widget signupView = BlocProvider<AuthCubit>(
    create: (context) => AuthCubit(getIt<AuthRepoImpl>()),
    child: const SignupView(),
  );

  static Widget completeGoogleSignupProcessView(OAuthCredential oAuthCredential) => BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(getIt<AuthRepoImpl>()),
        child: CompleteGoogleSignupProcess(oAuthCredential: oAuthCredential),
      );

  static final Widget favouriteView = BlocProvider<AddToCartCubit>(
    create: (context) => AddToCartCubit(getIt<MyBagRepoImpl>()),
    child: const FavouriteView(),
  );

  static Widget orderReviewView = BlocProvider<OrderReviewCubit>(
    create: (context) => OrderReviewCubit(getIt<MyBagRepoImpl>()),
    child: OrderReviewView(),
  );

  static final Widget searchView = MultiBlocProvider(
    providers: [
      BlocProvider<SearchCubit>(
        create: (context) => SearchCubit(getIt<SearchRepoImpl>(), getIt<SpeechToTextRepoImpl>()),
      ),
      BlocProvider<QrCodeScanningCubit>(
        create: (context) => QrCodeScanningCubit(getIt<SearchRepoImpl>()),
      ),
      BlocProvider<SpeechToTextCubit>(
        create: (context) => SpeechToTextCubit(getIt<SpeechToTextRepoImpl>()),
      ),
    ],
    child: const SearchView(),
  );

  static final Widget splashView = BlocProvider<UserCubit>(
    create: (context) => UserCubit(getIt<GetUserDataUseCase>()),
    child: const SplashView(),
  );

  static final Widget settingsView = BlocProvider<SettingsCubit>(
    create: (context) => SettingsCubit(getIt<ProfileRepoImpl>()),
    child: SettingsView(),
  );

  static final Widget productsStatistics = BlocProvider<ProductsStatisticsCubit>(
    create: (context) => ProductsStatisticsCubit(getIt<ProfileRepoImpl>()),
    child: const ProductsStatistics(),
  );

  static final Widget profileView = MultiBlocProvider(
    providers: [
      BlocProvider<MyProfileCubit>(
        create: (context) => MyProfileCubit(getIt<AuthRepoImpl>()),
      ),
      BlocProvider<ProfileImageCubit>(
        create: (context) => ProfileImageCubit(getIt<ProfileRepoImpl>()),
      ),
    ],
    child: const ProfileView(),
  );

  static Widget editProductView(Product product) => BlocProvider<ManageProductsCubit>(
        create: (context) => ManageProductsCubit(
          uploadProductUsecase: getIt<UploadProductUsecase>(),
          editProductUsecase: getIt<EditProductUsecase>(),
          deleteProductUsecase: getIt<DeleteProductUsecase>(),
        ),
        child: EditProductView(product: product),
      );

  static final Widget myOrdersView = BlocProvider<MyOrdersCubit>(
    create: (context) => MyOrdersCubit(getIt<ProfileRepoImpl>()),
    child: MyOrdersView(),
  );

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
