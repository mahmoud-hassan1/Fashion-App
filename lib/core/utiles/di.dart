import 'package:get_it/get_it.dart';
import 'package:online_shopping/Features/auth/data/repo_impl/auth_repo_imp.dart';
import 'package:online_shopping/Features/bag/data/repo_impl/my_bag_repo_impl.dart';
import 'package:online_shopping/Features/favourite/data/data_source/favourites_data_source.dart';
import 'package:online_shopping/Features/favourite/data/repo_impl/favourite_repo_impl.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/add_to_favourites.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/get_favourites_poducts.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/remove_from_favourites.dart';
import 'package:online_shopping/Features/home/data/data_source/home_data_source.dart';
import 'package:online_shopping/Features/home/data/repo_impl/home_repo_impl.dart';
import 'package:online_shopping/Features/home/domain/use_cases/get_newest_products.dart';
import 'package:online_shopping/Features/home/domain/use_cases/get_sale_products.dart';
import 'package:online_shopping/Features/product_management/data/data_source/manage_products_data_source.dart';
import 'package:online_shopping/Features/product_management/data/repo/manage_products_repo_impl.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/delete_product_usecase.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/edit_product_usecase.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/upload_product_usecase.dart';
import 'package:online_shopping/Features/profile/data/repo_impl/profile_repo_impl.dart';
import 'package:online_shopping/Features/reviews/data/repo_impl/product_reviews_repo_impl.dart';
import 'package:online_shopping/Features/search/data/repo_impl/search_repo_impl.dart';
import 'package:online_shopping/Features/search/data/repo_impl/speech_to_text_repo_impl.dart';
import 'package:online_shopping/Features/shop/data/data_source/shop_data_source.dart';
import 'package:online_shopping/Features/shop/data/repo/shop_repo_impl.dart';
import 'package:online_shopping/Features/shop/domain/use_cases/get_newest_products_by_cat.dart';
import 'package:online_shopping/Features/shop/domain/use_cases/get_products_by_cat.dart';
import 'package:online_shopping/Features/shop/domain/use_cases/get_sale_products_by_cat.dart';
import 'package:online_shopping/Features/splash/data/data_source/user_data_source.dart';
import 'package:online_shopping/Features/splash/data/repo/user_repo_impl.dart';
import 'package:online_shopping/Features/splash/domain/use_cases/get_user_data.dart';
import 'package:online_shopping/core/utiles/authentication_services.dart';
import 'package:online_shopping/core/utiles/firebase_firestore_services.dart';
import 'package:online_shopping/core/utiles/storage_services.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthServices>(AuthServices());
  getIt.registerSingleton<FirestoreServices>(FirestoreServices());
  getIt.registerSingleton<StorageServices>(StorageServices());

  getIt.registerSingleton<UserDataRepoImpl>(
    UserDataRepoImpl(
      UserDataSource(
        getIt<FirestoreServices>(),
        getIt<AuthServices>(),
      ),
    ),
  );

  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      getIt<UserDataRepoImpl>(),
      getIt<AuthServices>(),
      getIt<FirestoreServices>(),
      getIt<StorageServices>(),
    ),
  );

  getIt.registerSingleton<FavouriteRepoImpl>(
    FavouriteRepoImpl(
      FavouritesDataSource(
        getIt<FirestoreServices>(),
      ),
    ),
  );

  getIt.registerSingleton<MyBagRepoImpl>(
    MyBagRepoImpl(
      getIt<FavouriteRepoImpl>(),
      getIt<FirestoreServices>(),
    ),
  );

  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      HomeRemoteDataSource(
        getIt<FirestoreServices>(),
      ),
    ),
  );

  getIt.registerSingleton<ManageProductsRepoImpl>(
    ManageProductsRepoImpl(
      ManageProductsDataSource(
        getIt<FirestoreServices>(),
        getIt<StorageServices>(),
      ),
    ),
  );

  getIt.registerSingleton<ProfileRepoImpl>(
    ProfileRepoImpl(
      getIt<StorageServices>(),
      getIt<FirestoreServices>(),
      getIt<AuthServices>(),
    ),
  );

  getIt.registerSingleton<ProductReviewsRepoImpl>(
    ProductReviewsRepoImpl(
      getIt<FirestoreServices>(),
    ),
  );

  getIt.registerSingleton<ShopRepoImpl>(
    ShopRepoImpl(
      ShopRemoteDataSource(
        getIt<FirestoreServices>(),
      ),
    ),
  );

  getIt.registerSingleton<GetSaleProductsByCategory>(
    GetSaleProductsByCategory(
      getIt<ShopRepoImpl>(),
    ),
  );

  getIt.registerSingleton<GetNewestProductsByCategory>(
    GetNewestProductsByCategory(
      getIt<ShopRepoImpl>(),
    ),
  );

  getIt.registerSingleton<GetProductsByCategory>(
    GetProductsByCategory(
      getIt<ShopRepoImpl>(),
    ),
  );

  getIt.registerSingleton<AddToFavouritesUseCase>(
    AddToFavouritesUseCase(
      getIt<FavouriteRepoImpl>(),
    ),
  );

  getIt.registerSingleton<RemoveFromFavouritesUseCase>(
    RemoveFromFavouritesUseCase(
      getIt<FavouriteRepoImpl>(),
    ),
  );

  getIt.registerSingleton<GetSaleProducts>(
    GetSaleProducts(
      getIt<HomeRepoImpl>(),
    ),
  );

  getIt.registerSingleton<GetNewestProducts>(
    GetNewestProducts(
      getIt<HomeRepoImpl>(),
    ),
  );

  getIt.registerSingleton<GetFavouritesPoductsUseCase>(
    GetFavouritesPoductsUseCase(
      getIt<FavouriteRepoImpl>(),
    ),
  );

  getIt.registerSingleton<UploadProductUsecase>(
    UploadProductUsecase(
      getIt<ManageProductsRepoImpl>(),
    ),
  );

  getIt.registerSingleton<EditProductUsecase>(
    EditProductUsecase(
      getIt<ManageProductsRepoImpl>(),
    ),
  );

  getIt.registerSingleton<DeleteProductUsecase>(
    DeleteProductUsecase(
      getIt<ManageProductsRepoImpl>(),
    ),
  );

  getIt.registerSingleton<GetUserDataUseCase>(
    GetUserDataUseCase(
      getIt<UserDataRepoImpl>(),
    ),
  );

  getIt.registerSingleton<SearchRepoImpl>(
    SearchRepoImpl(
      getIt<FirestoreServices>(),
    ),
  );

  getIt.registerSingleton<SpeechToTextRepoImpl>(
    SpeechToTextRepoImpl(),
  );
}
