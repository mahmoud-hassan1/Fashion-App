import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/profile/data/repo_impl/profile_repo_impl.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/my_orders_cubit/my_orders_cubit.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/my_profile_cubit/my_profile_cubit.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/product_statistics_cubit/products_statistics_cubit.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/settings_cubit/settings_cubit.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/my_orders_view.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/my_profile_list_tile_item.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/products_statistics.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/profile_image.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/settings_view.dart';
import 'package:online_shopping/Features/splash/presentation/views/splash_view.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/storage.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/custtom_button.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyProfileCubit(ProfileRepoImpl(Storage())),
      child: BlocConsumer<MyProfileCubit, MyProfileState>(
        listener: (context, state) {
          if (state is MyProfileGoToSplash) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SplashView()),
              (Route<dynamic> route) => false,
            );
          } else if (state is MyProfileFailed) {
            snackBar(content: 'Something went wrong', context: context);
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("My Profile", style: Styles.kMediumTextStyle(context).copyWith(fontSize: 34)),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const ProfileImage(imageSize: 54, iconSize: 12),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(UserModel.getInstance().name, style: Styles.kFontSize17(context).copyWith(fontSize: 20)),
                                Text(UserModel.getInstance().email, style: Styles.kFontSize17(context).copyWith(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        MyProfileListTileItem(
                          title: "My Orders",
                          subtitle: "Orders report, Order reviews",
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => BlocProvider(
                                  create: (context) => MyOrdersCubit(ProfileRepoImpl(Storage())),
                                  child: MyOrdersView(),
                                ),
                              ),
                            );
                          },
                        ),
                        UserModel.getInstance().role == Role.admin
                            ? MyProfileListTileItem(
                                title: "Statistics",
                                subtitle: "Products statistics",
                                onPressed: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => BlocProvider(
                                        create: (context) => ProductsStatisticsCubit(ProfileRepoImpl(Storage())),
                                        child: const ProductsStatistics(),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const SizedBox(),
                        MyProfileListTileItem(
                          title: "Settings",
                          subtitle: "Personal Information, Password",
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => BlocProvider(
                                  create: (context) => SettingsCubit(ProfileRepoImpl(Storage())),
                                  child: SettingsView(),
                                ),
                              ),
                            );
                            setState(() {});
                          },
                        ),
                        const Expanded(child: SizedBox(height: 15)),
                        CustomButton(
                          height: 550,
                          label: 'LOGOUT',
                          onTap: () async {
                            BlocProvider.of<MyProfileCubit>(context).logout();
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomButton(
                          height: 550,
                          label: 'DELETE ACCOUNT',
                          onTap: () async {
                            BlocProvider.of<MyProfileCubit>(context).deleteAccount();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
