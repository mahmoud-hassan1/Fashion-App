import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/profile/data/models/products_statistics_model.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/product_statistics_cubit/products_statistics_cubit.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

class ProductsStatistics extends StatefulWidget {
  const ProductsStatistics({super.key});

  @override
  State<ProductsStatistics> createState() => _ProductsStatisticsState();
}

class _ProductsStatisticsState extends State<ProductsStatistics> {
  int touchedIndex = -1;
  int totalQuantities = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await BlocProvider.of<ProductsStatisticsCubit>(context).getProductsBestSelling();
    });

    return BlocConsumer<ProductsStatisticsCubit, ProductsStatisticsState>(
      listener: (context, state) {
        if (state is ProductsStatisticsFailed) {
          snackBar(content: 'Something went wrong', context: context);
        } else if (state is ProductsStatisticsSuccess) {
          totalQuantities = 0;
          for (ProductStatisticsModel element in state.productStatistics) {
            totalQuantities += element.quantity;
          }
          totalQuantities += (5 - (totalQuantities % 5));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ProductsStatisticsLoading,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Product Statistics", style: Styles.kFontSize30(context)),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    if (state is ProductsStatisticsSuccess)
                      Expanded(
                        child: BarChart(
                          BarChartData(
                            borderData: FlBorderData(show: false),
                            gridData: const FlGridData(show: false),
                            barGroups: List.generate(state.productStatistics.length.clamp(0, 10), (i) {
                              return makeGroupData(i, state.productStatistics[i].percentage, isTouched: i == touchedIndex);
                            }),
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) => getBottomTitles(context, value, meta, state.productStatistics), reservedSize: 100),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) => getLeftTitles(context, value, meta), reservedSize: 28, interval: 1),
                              ),
                            ),
                            barTouchData: BarTouchData(
                              touchCallback: (FlTouchEvent event, barTouchResponse) {
                                if (!event.isInterestedForInteractions || barTouchResponse == null || barTouchResponse.spot == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                              },
                              touchTooltipData: BarTouchTooltipData(
                                getTooltipColor: (_) => const Color(0xff101214),
                                tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                  String productName = state.productStatistics[groupIndex].name;
                                  int productQuantity = state.productStatistics[groupIndex].quantity;
                                  return BarTooltipItem(
                                    '',
                                    const TextStyle(),
                                    textAlign: TextAlign.left,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ("${productName.length > 9 ? "${productName.substring(0, 9)}..." : productName}\n").toString(),
                                        style: Styles.kFontSize14(context).copyWith(color: Colors.white).copyWith(fontSize: 14),
                                      ),
                                      TextSpan(
                                        text: ("Percentage:  ").toString(),
                                        style: Styles.kFontSize14(context).copyWith(color: Colors.grey),
                                      ),
                                      TextSpan(
                                        text: ("${rod.toY}%\n").toString(),
                                        style: Styles.kFontSize14(context).copyWith(color: Colors.white),
                                      ),
                                      TextSpan(
                                        text: ("Quantity:  ").toString(),
                                        style: Styles.kFontSize14(context).copyWith(color: Colors.grey),
                                      ),
                                      TextSpan(
                                        text: ("$productQuantity").toString(),
                                        style: Styles.kFontSize14(context).copyWith(color: Colors.white),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  BarChartGroupData makeGroupData(int x, double y, {bool isTouched = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 15,
          color: const Color(0xffdb3022),
          borderRadius: BorderRadius.circular(5),
          backDrawRodData: BackgroundBarChartRodData(show: true, toY: 100, color: Colors.grey[100]),
        ),
      ],
    );
  }

  Widget getBottomTitles(BuildContext context, double value, TitleMeta meta, List<ProductStatisticsModel> productsStatistics) {
    final List<String> productsNames = List<String>.generate(productsStatistics.length, (int index) => productsStatistics[index].name);
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SideTitleWidget(
        angle: -(pi / 2) + .4,
        axisSide: meta.axisSide,
        space: 0,
        child: Text(
          productsNames[value.toInt()].length > 9 ? "${productsNames[value.toInt()].substring(0, 9)}..." : productsNames[value.toInt()],
          style: Styles.kFontSize17(context),
        ),
      ),
    );
  }

  Widget getLeftTitles(BuildContext context, double value, TitleMeta meta) {
    String text = "";
    if (value.toInt() % 25 == 0) {
      text = "${value.toInt()}";
    }
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(text, style: Styles.kFontSize17(context)),
      ),
    );
  }
}
