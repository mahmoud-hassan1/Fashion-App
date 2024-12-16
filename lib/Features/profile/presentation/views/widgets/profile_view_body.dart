import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/my_profile_cubit/my_profile_cubit.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/my_profile_list_tile_item.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/profile_image.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/routes.dart';
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
    return BlocConsumer<MyProfileCubit, MyProfileState>(
      listener: (context, state) {
        if (state is MyProfileGoToSplash) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AppRouter.loginView),
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
                      Text("My Profile", style: Styles.kLargeTextStyle(context)),
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
                        title: UserModel.getInstance().role == Role.admin ? "Orders" : "My Orders",
                        subtitle: "Orders report, Order reviews",
                        onPressed: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => AppRouter.myOrdersView,
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
                                    builder: (BuildContext context) => AppRouter.productsStatistics,
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
                              builder: (BuildContext context) => AppRouter.settingsView,
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
                          await BlocProvider.of<MyProfileCubit>(context).logout();
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomButton(
                        height: 550,
                        label: 'DELETE ACCOUNT',
                        onTap: () async {
                          await BlocProvider.of<MyProfileCubit>(context).deleteAccount();
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
    );
  }
}
