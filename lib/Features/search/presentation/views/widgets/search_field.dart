import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.searchText, required this.onSubmitted});

  final TextEditingController searchText;
  final Future<void> Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 35,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: TextField(
            onSubmitted: onSubmitted,
            controller: searchText,
            decoration: InputDecoration(
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => onSubmitted(searchText.text),
                    icon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.black,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.kRed, width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
              hintText: "Search",
              hintStyle: Styles.kFontSize14(context).copyWith(fontSize: 16),
            ),
            style: Styles.kFontSize17(context).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
