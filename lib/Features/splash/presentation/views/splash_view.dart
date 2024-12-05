import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/splash/data/data_source/user_data_source.dart';
import 'package:online_shopping/Features/splash/data/repo/user_repo_impl.dart';
import 'package:online_shopping/Features/splash/domain/repo/user_data_repo.dart';
import 'package:online_shopping/Features/splash/domain/use_cases/get_user_data.dart';
import 'package:online_shopping/Features/splash/presentation/cubits/cubit/user_cubit.dart';
import 'package:online_shopping/Features/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (context) => UserCubit(getUserDataUseCase: GetUserDataUseCase(UserRepoImpl(UserDataSource(FirebaseFirestore.instance)))),
      child: const Scaffold(
        body: SplashViewBody() ,
      ),
    );
  }
}