import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/product_details/presentation/views/product_details_view/widgets/details_list_view_item.dart';

class ProductListViewImages extends StatefulWidget {
  const ProductListViewImages({super.key, required this.images});
  final List<String> images;
  @override
  State<ProductListViewImages> createState() => _ProductListViewImagesState();
}

class _ProductListViewImagesState extends State<ProductListViewImages> {
  int _current = 0;
  Widget buildIndicator(int index) {
    return Container(
      width: _current == index ? 15 : 8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        borderRadius: _current == index ? BorderRadius.circular(10) : null,
        shape: _current == index ? BoxShape.rectangle : BoxShape.circle,
        color: _current == index ? Colors.black : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          itemBuilder: (context, index, realIndex) {
            return DetailsListViewItem(
              index: index,
              photos: widget.images,
            );
          },
          options: CarouselOptions(
            height: (width * 1.3).clamp(0, 470),
            autoPlayInterval: const Duration(milliseconds: 3000),
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.images.length, (index) => buildIndicator(index)),
        ),
      ],
    );
  }
}
