import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.searchText, required this.onChanged});

  final TextEditingController searchText;

  final Future<void> Function(String) onChanged;

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
            onChanged: onChanged,
            controller: searchText,
            decoration: InputDecoration(
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
