import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class MyProfileListTileItem extends StatelessWidget {
  const MyProfileListTileItem({super.key, required this.title, required this.subtitle, this.onPressed});

  final String title;
  final String subtitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      splashColor: Colors.transparent,
      title: Text(title, style: Styles.kFontSize17(context).copyWith(fontSize: 20)),
      subtitle: Text(subtitle, style: Styles.kFontSize17(context).copyWith(fontSize: 12, color: Colors.grey)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
