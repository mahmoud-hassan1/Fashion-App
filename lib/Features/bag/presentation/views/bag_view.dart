import 'package:flutter/material.dart';
import 'package:online_shopping/Features/bag/presentation/views/widgets/bag_view_body.dart';

class BagView extends StatelessWidget {
  const BagView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BagViewBody(),
    );
  }
}
