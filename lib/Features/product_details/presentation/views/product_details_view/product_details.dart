import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/add_product/presentation/views/edit_product_view.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/product_details/presentation/cubits/product_details_cubit/product_details_cubit.dart';
import 'package:online_shopping/Features/product_details/presentation/views/product_details_view/widgets/details_list_view_item.dart';
import 'package:online_shopping/Features/reviews/data/repo_impl/product_reviews_repo_impl.dart';
import 'package:online_shopping/Features/reviews/presentation/cubits/product_reviews_cubit/product_reviews_cubit.dart';
import 'package:online_shopping/Features/reviews/presentation/views/product_reviews_view.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/custtom_button.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  ProductDetails({super.key, required this.product});

  Product product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late bool _fav;
  late bool isLoading;

  @override
  void initState() {
    _fav = UserModel.getInstance().favourites.contains(widget.product.id);
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (BuildContext context) => ProductReviewsCubit(ProductReviewsRepoImpl()),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is ProductDetailsLoading) {
            isLoading = true;
            return;
          } else if (state is ProductDetailsFailed) {
            snackBar(content: state.message, context: context);
          } else if (state is ProductDetailsRefresh) {
            widget.product = state.product;
          } else if (state is ProductDetailsAddedToCart) {
            snackBar(content: "Product added to cart successfully", context: context, color: Colors.green);
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
                  widget.product.subtitle,
                  style: Styles.kFontSize30(context),
                ),
                actions: [
                  UserModel.getInstance().role.value == 'admin'
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProductView(product: widget.product),
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
                    CarouselSlider.builder(
                      itemCount: 1, // Number of items in the slider
                      itemBuilder: (context, index, realIndex) {
                        return DetailsListViewItem(
                          index: index,
                          photos: [widget.product.image],
                        );
                      },
                      options: CarouselOptions(
                        height: (width * 1.3).clamp(0, 470),
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  if (_fav) {
                                    await BlocProvider.of<ProductDetailsCubit>(context).removeFromFavourites(widget.product.id);
                                  } else {
                                    await BlocProvider.of<ProductDetailsCubit>(context).addToFavourites(widget.product.id);
                                  }

                                  _fav = !_fav;
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: _fav ? Colors.red : Colors.grey,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(widget.product.name, style: Styles.kFontSize30(context)),
                              const Spacer(),
                              Text("\$${widget.product.price}", style: Styles.kFontSize30(context)),
                            ],
                          ),
                          Text(
                            widget.product.subtitle,
                            style: Styles.kFontSize14(context),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductReviewsView(product: widget.product)));
                                },
                                child: RatingBarIndicator(
                                  rating: widget.product.rate,
                                  itemSize: 15.r,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              Text(
                                "(${widget.product.reviews.length.toString()})",
                                style: Styles.kFontSize14(context).copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            widget.product.description,
                            style: Styles.kFontSize17(context).copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CustomButton(
                            onTap: () async {
                              await BlocProvider.of<ProductDetailsCubit>(context).addToCart(widget.product.id);
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
