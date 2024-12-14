import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/delete_product_usecase.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/edit_product_usecase.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/upload_product_usecase.dart';
import 'package:online_shopping/Features/product_management/presentation/manger/manage_products/manage_products_cubit.dart';
import 'package:online_shopping/Features/product_management/presentation/views/widgets/edit_product_body.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/core/utiles/di.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManageProductsCubit>(
      create: (context) => ManageProductsCubit(
        uploadProductUsecase: getIt<UploadProductUsecase>(),
        editProductUsecase: getIt<EditProductUsecase>(),
        deleteProductUsecase: getIt<DeleteProductUsecase>(),
      ),
      child: Scaffold(
        body: EditProductBody(product: product),
      ),
    );
  }
}
