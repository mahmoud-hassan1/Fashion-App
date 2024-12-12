import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/profile/data/repo_impl/profile_repo_impl.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/my_orders_cubit/my_orders_cubit.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/my_orders_view.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/my_profile_list_tile_item.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/profile_image.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/storage.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/scale_down.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleDown(child: Text("My Profile", style: Styles.kMediumTextStyle(context).copyWith(fontSize: 34))),
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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => BlocProvider(
                      create: (context) => MyOrdersCubit(ProfileRepoImpl(Storage())),
                      child: MyOrdersView(),
                    ),
                  ),
                );
              },
            ),
            MyProfileListTileItem(title: "Settings", subtitle: "Password, Logout", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
