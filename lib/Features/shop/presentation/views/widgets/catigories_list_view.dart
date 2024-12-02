import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/constants.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class CatigoriesListView extends StatelessWidget {
  const CatigoriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return AspectRatio(
          aspectRatio: 3/1,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            decoration: BoxDecoration(
    
              color:  Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(width: 24,),
                      Text(
                        kCategoryList[index].first,
                      style: Styles.kMediumTextStyle(context).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Image.asset(kCategoryList[index].last,fit: BoxFit.fitWidth,),
                ),
              ],
            ),
          ),
        );
      },
      childCount: kCategoryList.length,
    ),
    );
  }
}

