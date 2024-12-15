import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/bag/data/models/my_bag_item_model.dart';
import 'package:online_shopping/Features/bag/presentation/cubits/my_bag_cubit/my_bag_cubit.dart';
import 'package:online_shopping/Features/bag/presentation/views/widgets/quantity_picker.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/scale_down.dart';

class MyBagItem extends StatelessWidget {
  const MyBagItem({super.key, required this.myBagItemModel});

  final MyBagItemModel myBagItemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).width * .3,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.3), blurStyle: BlurStyle.normal, blurRadius: 5, offset: const Offset(0, 3), spreadRadius: 0),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CachedNetworkImage(
              imageUrl: myBagItemModel.product.image,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(myBagItemModel.product.name, style: Styles.kSmallTextStyle(context)),
                  ),
                  QuantityPicker(
                    quan: myBagItemModel.quan,
                    maxValue: myBagItemModel.product.stock,
                    onChanged: (number) {
                      myBagItemModel.quan = number;
                      BlocProvider.of<MyBagCubit>(context).updateTotalPrice();
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ScaleDown(
                    child: PopupMenuButton<String>(
                      color: Colors.white,
                      elevation: 20,
                      padding: EdgeInsets.zero,
                      child: const Icon(Icons.more_vert, color: Colors.grey),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: '1',
                            child: const Text('Add to favorites'),
                            onTap: () async => BlocProvider.of<MyBagCubit>(context).addToFavourites(myBagItemModel.product.id),
                          ),
                          PopupMenuItem(
                            value: '2',
                            child: const Text('Delete from the list'),
                            onTap: () async => BlocProvider.of<MyBagCubit>(context).deleteItemFromBag(myBagItemModel.product.id),
                          ),
                        ];
                      },
                    ),
                  ),
                  ScaleDown(
                    child: Text(
                      "${myBagItemModel.product.price.toStringAsFixed(2)}\$",
                      style: Styles.kSmallTextStyle(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
