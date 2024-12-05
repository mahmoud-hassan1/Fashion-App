import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/Features/product/presentation/views/product_details_view/widgets/details_list_view_item.dart';
import 'package:online_shopping/core/utiles/styles.dart';

import '../../../../../core/widgets/custtom_button.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _current = 0;
  bool _fav = false;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Short Dress",
          style: Styles.kFontSize30(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              size: 30,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: 2, // Number of items in the slider
            itemBuilder: (context, index, realIndex) {
              return DetailsListViewItem(
                index: index,
              );
            },
            options: CarouselOptions(
              height: (width * 1.3).clamp(0, 470),
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index; // Update the current page index
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _fav = !_fav;
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: _fav ? Colors.red : Colors.grey,
                        ))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "H&M",
                      style: Styles.kFontSize30(context),
                    ),
                    Spacer(),
                    Text(
                      "\$19.99",
                      style: Styles.kFontSize30(context),
                    )
                  ],
                ),
                Text(
                  "Short Black Dress",
                  style: Styles.kFontSize14(context),
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: 2.8,
                      itemSize: 15.r,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      "(10)",
                      style: Styles.kFontSize14(context),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  "Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline with concealed elastication. Elasticated seam under the bust and short puff sleeves with a small frill trim.",
                  style: Styles.kFontSize17(context).copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.h,),
                CustomButton(height:height*.9 ,label: "Add to cart",)

              ],
            ),
          )
        ],
      ),
    );
  }
}
