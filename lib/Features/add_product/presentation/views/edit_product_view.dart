import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/add_product/data/data_source/manage_products_data_source.dart';
import 'package:online_shopping/Features/add_product/data/repo/manage_products_repo_impl.dart';
import 'package:online_shopping/Features/add_product/domain/usecases/upload_product_usecase.dart';
import 'package:online_shopping/Features/add_product/presentation/manger/manage_products/manage_products_cubit.dart';
import 'package:online_shopping/Features/add_product/presentation/views/widgets/edit_product_body.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({super.key});

  @override
  Widget build(BuildContext context) {
   return BlocProvider(
      create: (context) => ManageProductsCubit(uploadProductUsecase: UploadProductUsecase(repository: ManageProductsRepoImpl(dataSource: ManageProductsDataSource(firestore: FirebaseFirestore.instance)))),
      child: const Scaffold(
        body: EditProductBody(),
      ),
    );
  }
}