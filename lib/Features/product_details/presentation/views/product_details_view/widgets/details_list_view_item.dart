import 'package:cached_network_image/cached_network_image.dart';
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
            child: CachedNetworkImage(
             imageUrl: photos[index],
            errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.contain,
              width: width,
            ),
          ),
        ),
      ],
    );
  }
}
