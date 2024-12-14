import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/profile/data/repo_impl/profile_repo_impl.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/profile_image_cubit/profile_image_cubit.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/di.dart';
import 'package:online_shopping/core/utiles/assets.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.imageSize, required this.iconSize});

  final double imageSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileImageCubit>(
      create: (context) => ProfileImageCubit(getIt<ProfileRepoImpl>()),
      child: BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, state) {
          if (state is ProfileImageLoading) {
            return getLoadingWidget();
          } else if (state is ProfileImageFinished || state is ProfileImageInitial) {
            return getImageWidget(context);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget getLoadingWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      width: imageSize,
      height: imageSize,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.black12,
      ),
      child: const CircularProgressIndicator(color: Color(0xffdb3022)),
    );
  }

  Widget getImageWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: imageSize,
          height: imageSize,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Image.network(
            UserModel.getInstance().profilePicturePath,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: const Color(0xffdb3022),
                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Image.asset(Assets.imagesDefaultProfileImage),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: iconSize - 2,
            backgroundColor: Colors.black26,
            child: IconButton(
              onPressed: () async {
                await BlocProvider.of<ProfileImageCubit>(context).updateProfileImage();
              },
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.edit),
              color: Colors.black,
              iconSize: iconSize,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
            radius: iconSize - 2,
            backgroundColor: Colors.black26,
            child: IconButton(
              onPressed: () async {
                await BlocProvider.of<ProfileImageCubit>(context).deleteImage();
              },
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.clear),
              color: Colors.black,
              iconSize: iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
