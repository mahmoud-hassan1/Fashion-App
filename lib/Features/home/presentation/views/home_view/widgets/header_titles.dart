import 'package:flutter/material.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/shop/presentation/views/products_screen.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';


class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title, required this.products,
  });
  final List<Product> products;
final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            title,
            style: Styles.kLargeTextStyle(context)
          ),
          const Spacer(),
          InkWell(
            onTap: (){
              Navigator.push(context,  MaterialPageRoute(builder: (context) => ProductsScreen(title: title,products: products,),));
            },
            child: Row(
              children: [
                Text(
                  "See all",
                  style: Styles.kSmallTextStyle(context),
                  ),
                  const SizedBox(width: 8,),
              Container(
                decoration: BoxDecoration(
                   color: AppColors.kItemBackgroundColor,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: const Icon(Icons.keyboard_arrow_right_outlined),
              )
              ],
            ),
          ),
            
        ],
      ),
    );
  }
}

class ColorStyles {
}