import 'package:flutter/material.dart' hide CarouselController;

class DetailsListViewItem extends StatelessWidget {
  const DetailsListViewItem({super.key, required this.index, required this.photos});

  final int index;
  final List<String> photos;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          height: (width * 1.3).clamp(0, 450),
          child: AspectRatio(
            aspectRatio: 5 / 4,
            child: Image.network(
              photos[index],
              fit: BoxFit.contain,
              width: width,
            ),
          ),
        ),
      ],
    );
  }
}
