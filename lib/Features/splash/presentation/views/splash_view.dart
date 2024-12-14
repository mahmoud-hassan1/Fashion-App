import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/splash/domain/use_cases/get_user_data.dart';
import 'package:online_shopping/Features/splash/presentation/cubits/cubit/user_cubit.dart';
import 'package:online_shopping/Features/splash/presentation/views/widgets/splash_view_body.dart';
import 'package:online_shopping/core/utiles/di.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (context) => UserCubit(getIt<GetUserDataUseCase>()),
      child: const Scaffold(
        body: SplashViewBody(),
      ),
    );
  }
}
