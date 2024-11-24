import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/offers_list_view_item.dart';


class OffersListView extends StatefulWidget {
  const OffersListView({super.key});

  @override
  OffersListViewState createState() => OffersListViewState();
}

class OffersListViewState extends State<OffersListView> {
  int _current = 0; // Current index for the slider

  @override
  Widget build(BuildContext context) {
    double width =MediaQuery.of(context).size.width;
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: 2, // Number of items in the slider
          itemBuilder: (context, index, realIndex) {
            return   OffersListViewItem(index: index,);
          },
          options: CarouselOptions(
            height: (width*1.3).clamp(0, 800),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) => buildIndicator(index)), // Generate indicators
        ),
      ],
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      width:_current ==index? 15:8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        borderRadius:_current ==index? BorderRadius.circular(10):null,
        shape: _current ==index?BoxShape.rectangle :BoxShape.circle,
        color: _current == index ? Colors.black : Colors.grey,
      ),
    );
  }
}