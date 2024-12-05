import 'package:flutter/material.dart' hide CarouselController;
import 'package:online_shopping/core/utiles/styles.dart';


class DetailsListViewItem extends StatelessWidget {
  DetailsListViewItem({super.key, required this.index});
  final int index ;
  final List<String> collection=['assets/images/shortyDress.png','assets/images/Sale.png'];
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          height: (width*1.3).clamp(0, 450),
          child: AspectRatio(
            aspectRatio: 5/4,
            child: Image.asset(
              collection[index],
              fit: BoxFit.contain,

              width: width,
            ),
          ),
        ),

      ],
    );
  }
}