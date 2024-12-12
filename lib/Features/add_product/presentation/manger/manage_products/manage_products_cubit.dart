import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/add_product/domain/usecases/upload_product_usecase.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';

part 'manage_products_state.dart';

class ManageProductsCubit extends Cubit<ManageProductsState> {
  final UploadProductUsecase uploadProductUsecase;
  ManageProductsCubit({required this.uploadProductUsecase}) : super(ManageProductsInitial());
  uploadProduct({required ProductModel product,  required List<File> selectedImages,}) async{
  try{emit(AddProductsLoading());
  await uploadProductUsecase.call(product: product, selectedImages: selectedImages);
  emit(AddProductsSucsses());
  }
  catch(e){
  emit(AddProductsFailed(error: e.toString()));
  }
  }
}
