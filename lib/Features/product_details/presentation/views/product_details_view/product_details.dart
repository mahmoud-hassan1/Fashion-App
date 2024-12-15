import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/product_details/presentation/views/product_details_view/widgets/product_list_view_images.dart';
import 'package:online_shopping/Features/product_management/presentation/views/edit_product_view.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/product_details/presentation/cubits/product_details_cubit/product_details_cubit.dart';
import 'package:online_shopping/Features/reviews/data/repo_impl/product_reviews_repo_impl.dart';
import 'package:online_shopping/Features/reviews/presentation/cubits/product_reviews_cubit/product_reviews_cubit.dart';
import 'package:online_shopping/Features/reviews/presentation/views/product_reviews_view.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/di.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/custtom_button.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

import '../../../../../core/widgets/qr_widget.dart';

// ignore: must_be_immutable
class ProductDetails extends StatelessWidget {
  ProductDetails({super.key, required this.product});

  Product product;

  late bool _fav;

   bool isLoading=false;

  @override
  Widget build(BuildContext context) {
     _fav = UserModel.getInstance().favourites.contains(product.id);
    double height = MediaQuery.of(context).size.height;
    return BlocProvider<ProductReviewsCubit>(
      create: (BuildContext context) =>
          ProductReviewsCubit(getIt<ProductReviewsRepoImpl>()),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is ProductDetailsLoading) {
            isLoading = true;
            return;
          } else if (state is ProductDetailsFailed) {
            snackBar(content: state.message, context: context);
          } else if (state is ProductDetailsRefresh) {
            product = state.product;
          } else if (state is ProductDetailsAddedToCart) {
            snackBar(
                content: "Product added to cart successfully",
                context: context,
                color: Colors.green);
            Navigator.of(context).pop();
          }
          isLoading = false;
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  product.subtitle,
                  style: Styles.kFontSize30(context),
                ),
                actions: [
                  UserModel.getInstance().role == Role.admin
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>

                                    EditProductView(product: product),

                            

                              ),
                            );
                          },
                          icon: const Icon(Icons.edit))
                      : const SizedBox()
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ProductListViewImages(images: product.images),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    QrWidget()
                                        .qrDialog(context, product.name);
                                  },
                                  icon: const Icon(
                                    Icons.qr_code,
                                    size: 28,
                                  )),
                              IconButton(
                                onPressed: () async {
                                   if (_fav) {
                                    await BlocProvider.of<ProductDetailsCubit>(
                                            context)
                                        .removeFromFavourites(
                                            product.id);
                                  } else {
                                    await BlocProvider.of<ProductDetailsCubit>(
                                            context)
                                        .addToFavourites(product.id);
                                  }
                                  _fav = !_fav;
                          
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: _fav ? Colors.red : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [

                              Text(product.name,
                                  style: Styles.kFontSize30(context)),
                              const Spacer(),
                              Text("\$${product.price}",
                               style: Styles.kFontSize30(context)
                              )

                            ],
                          ),
                          Text(
                            product.subtitle,
                            style: Styles.kFontSize14(context),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ProductReviewsView(

                                                  product: product)));

                                },
                                child: RatingBarIndicator(
                                  rating: product.rate,
                                  itemSize: 15.r,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              Text(

                                "(${product.reviews.length.toString()})",
                                style: Styles.kFontSize14(context).copyWith(color: Colors.grey),

                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            product.description,
                            style: Styles.kFontSize17(context).copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CustomButton(
                            onTap: () async {
                              await BlocProvider.of<ProductDetailsCubit>(
                                      context)

                                  .addToCart(product.id);

                            },
                            height: height * .9,
                            label: "Add to cart",
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
