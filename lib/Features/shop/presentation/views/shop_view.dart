import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_shopping/Features/shop/presentation/views/widgets/shop_view_body.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/constants.dart';
import 'package:online_shopping/core/utiles/routes.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:page_transition/page_transition.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: kTypes.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: Styles.kFontSize30(context).copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: AppRouter.searchView, childCurrent: const ShopView()));
            },
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 27,
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabAlignment: TabAlignment.fill,
          isScrollable: false,
          indicatorColor: AppColors.kRed,
          dividerColor: Colors.transparent,
          tabs: kTypes
              .map(
                (category) => Tab(
                  child: Text(
                    category,
                    style: Styles.kSmallTextStyle(context),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: ShopViewBody(tabController: _tabController),
    );
  }
}
