import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/home/data/repo_impl/home_repo_impl.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/home_view_body.dart';
import 'package:online_shopping/Features/home/presentation/cubits/sale_cubit/sale_cubit.dart';
import 'package:online_shopping/Features/home/presentation/cubits/newest_cubit/newest_cubit.dart';
import 'package:online_shopping/Features/home/domain/use_cases/get_sale_products.dart';
import 'package:online_shopping/Features/home/domain/use_cases/get_newest_products.dart';
import 'package:online_shopping/Features/home/domain/repo_interface/home_repo.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: HomeViewBody(),
    );
  }
}