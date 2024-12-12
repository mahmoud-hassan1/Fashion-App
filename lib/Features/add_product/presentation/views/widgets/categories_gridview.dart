import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/constants.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class CategoriesGridview extends StatefulWidget {
const CategoriesGridview({super.key, required this.selectedCategories});
final Set<String> selectedCategories ;
  @override
  State<CategoriesGridview> createState() => _CategoriesGridviewState();
}

class _CategoriesGridviewState extends State<CategoriesGridview> {
    void _toggleCategorySelection(String category) {
    setState(() {
      if (widget.selectedCategories.contains(category.toLowerCase())) {
        widget.selectedCategories.remove(category.toLowerCase());
      } else {
        widget.selectedCategories.add(category.toLowerCase());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return   GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: kAllCategories.length,
                          itemBuilder: (context, index) {
                            final category = kAllCategories[index];
                            final isSelected =
                                widget.selectedCategories.contains(category.toLowerCase());
                            return GestureDetector(
                              onTap: () => _toggleCategorySelection(category),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                alignment: Alignment.center,
                                child: Text(category,
                                    style: Styles.kSmallTextStyle(context)
                                        .copyWith(fontWeight: FontWeight.bold)),
                              ),
                            );
                          },
                        );
  }
}