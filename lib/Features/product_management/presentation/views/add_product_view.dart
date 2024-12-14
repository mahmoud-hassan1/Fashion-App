import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/delete_product_usecase.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/edit_product_usecase.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/upload_product_usecase.dart';
import 'package:online_shopping/Features/product_management/presentation/manger/manage_products/manage_products_cubit.dart';
import 'package:online_shopping/Features/product_management/presentation/views/widgets/add_product_body.dart';
import 'package:online_shopping/core/utiles/di.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManageProductsCubit>(
      create: (context) => ManageProductsCubit(
        uploadProductUsecase: getIt<UploadProductUsecase>(),
        editProductUsecase: getIt<EditProductUsecase>(),
        deleteProductUsecase: getIt<DeleteProductUsecase>(),
      ),
      child: const Scaffold(
        body: AddProductBody(),
      ),
    );
  }
}
