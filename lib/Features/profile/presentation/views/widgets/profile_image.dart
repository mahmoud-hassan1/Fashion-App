import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/profile_image_cubit/profile_image_cubit.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/assets.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.imageSize, required this.iconSize});

  final double imageSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
      builder: (context, state) {
        if (state is ProfileImageLoading) {
          return getLoadingWidget();
        } else if (state is ProfileImageFinished || state is ProfileImageInitial) {
          return getImageWidget(context);
        } else {
          return const SizedBox();
        }
      },
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
          child: CachedNetworkImage(
            imageUrl: UserModel.getInstance().profilePicturePath,
            progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(
              value: downloadProgress.progress,
              color: const Color(0xffdb3022),
            ),
            errorWidget: (context, error, stackTrace) {
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
