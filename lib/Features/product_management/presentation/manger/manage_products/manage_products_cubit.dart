import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/delete_product_usecase.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/edit_product_usecase.dart';
import 'package:online_shopping/Features/product_management/domain/usecases/upload_product_usecase.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';

part 'manage_products_state.dart';

class ManageProductsCubit extends Cubit<ManageProductsState> {
  final UploadProductUsecase uploadProductUsecase;
  final EditProductUsecase editProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;

  ManageProductsCubit({required this.uploadProductUsecase, required this.editProductUsecase, required this.deleteProductUsecase}) : super(ManageProductsInitial());

  addProduct({required ProductModel product, required List<File> selectedImages}) async {
    try {
      emit(AddProductsLoading());
      await uploadProductUsecase.call(product: product, selectedImages: selectedImages);
      emit(AddProductsSucsses());
    } catch (e) {
      emit(AddProductsFailed(error: e.toString().replaceFirst('Exception:', '').trim()));
    }
  }

  editProduct({required ProductModel product}) async {
    try {
      emit(AddProductsLoading());
      await editProductUsecase.call(product: product);
      emit(AddProductsSucsses());
    } catch (e) {
      emit(AddProductsFailed(error: e.toString().replaceFirst('Exception:', '').trim()));
    }
  }

  deleteProduct({required ProductModel product}) async {
    try {
      emit(AddProductsLoading());
      await deleteProductUsecase.call(product: product);
      emit(AddProductsSucsses());
    } catch (e) {
      
      emit(AddProductsFailed(error:e.toString().replaceFirst('Exception:', '').trim()));
    }
  }
}
