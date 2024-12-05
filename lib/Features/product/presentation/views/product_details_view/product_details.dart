import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/bag/data/repo_impl/bag_repo_impl.dart';
import 'package:online_shopping/Features/favourite/data/repo_impl/favourite_repo_impl.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/product/presentation/cubits/product_details_cubit/product_details_cubit.dart';
import 'package:online_shopping/Features/product/presentation/views/product_details_view/widgets/details_list_view_item.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';
import '../../../../../core/widgets/custtom_button.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late bool _fav;
  late bool isLoading;

  @override
  void initState() {
    _fav = UserModel.getInstance().favourites!.contains(widget.product.id);
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => ProductDetailsCubit(BagRepoImpl(FavouriteRepoImpl(firestore: FirebaseFirestore.instance))),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is ProductDetailsLoading) {
            isLoading = true;
            return;
          } else if (state is ProductDetailsFailed) {
            snackBar(content: state.message, context: context);
          }
          isLoading = false;
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                title: Text(
                  widget.product.subtitle,
                  style: Styles.kFontSize30(context),
                ),
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
                              RatingBarIndicator(
                                rating: widget.product.rate,
                                itemSize: 15.r,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
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
