import 'package:flutter/material.dart' hide CarouselController;
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: HomeViewBody(),
    );
  }
}