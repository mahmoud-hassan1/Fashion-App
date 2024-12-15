import 'package:flutter/cupertino.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/search/presentation/views/widgets/result_item.dart';

class ResultListView extends StatelessWidget {
  const ResultListView({super.key, required this.products});
 final List<Product> products;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ResultItem(product: products[index],);
      },
      itemCount:products.length,

      physics: NeverScrollableScrollPhysics(),
    );
  }
}
