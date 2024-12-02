import 'package:flutter/material.dart' hide CarouselController;
import 'package:online_shopping/core/utiles/styles.dart';


class OffersListViewItem extends StatelessWidget {
   OffersListViewItem({super.key, required this.index});
  final int index ; 
  final List<dynamic> collection=[['assets/images/Sale.png',"Fation Sale"],['assets/images/New.png',"New Collection"],];
  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
           height: (width*1.3).clamp(0, 800),
          child: Image.asset(
            collection[index][0],
            fit: BoxFit.cover,
            width: width,
          ),
        ),
        Positioned(
          bottom: width*.15,
          left: 16,
          child: Text(
          // Split the text by spaces and join with newlines
          collection[index][1].split(' ').join('\n'),
          style: Styles.kFontSize60(context),
          )
          )
      ],
    );
  }
}