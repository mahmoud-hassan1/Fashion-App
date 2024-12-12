import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/add_product/data/data_source/manage_products_data_source.dart';
import 'package:online_shopping/Features/add_product/data/repo/manage_products_repo_impl.dart';
import 'package:online_shopping/Features/add_product/domain/usecases/edit_product_usecase.dart';
import 'package:online_shopping/Features/add_product/domain/usecases/upload_product_usecase.dart';
import 'package:online_shopping/Features/add_product/presentation/manger/manage_products/manage_products_cubit.dart';
import 'package:online_shopping/Features/add_product/presentation/views/widgets/edit_product_body.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
  final repo=  ManageProductsRepoImpl(dataSource: ManageProductsDataSource(firestore: FirebaseFirestore.instance));
   return BlocProvider(
      create: (context) => ManageProductsCubit(uploadProductUsecase: UploadProductUsecase(repository:repo), editProductUsecase: EditProductUsecase(repository: repo)),
      child:  Scaffold(
        body: EditProductBody(product: product),
      ),
    );
  }
}