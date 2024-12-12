import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/add_product/presentation/manger/manage_products/manage_products_cubit.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

class SubmitEditsButton extends StatelessWidget {
  const SubmitEditsButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required ValueNotifier<List<File>> selectedImages,
    required TextEditingController nameController,
    required TextEditingController subtitleController,
    required TextEditingController descriptionController,
    required TextEditingController priceController,
    required TextEditingController stockController,
    required Set<String> selectedCategories, required TextEditingController priceAfterDiscountController,required TextEditingController discountController,
  }) :_priceAfterDiscountController=priceAfterDiscountController,_discountController=discountController, _formKey = formKey, _selectedImages = selectedImages, _nameController = nameController, _subtitleController = subtitleController, _descriptionController = descriptionController, _priceController = priceController, _stockController = stockController, _selectedCategories = selectedCategories;

  final GlobalKey<FormState> _formKey;
  final ValueNotifier<List<File>> _selectedImages;
  final TextEditingController _nameController;
  final TextEditingController _subtitleController;
  final TextEditingController _descriptionController;
  final TextEditingController _priceController;
  final TextEditingController _stockController;
  final Set<String> _selectedCategories;
final TextEditingController _priceAfterDiscountController;
final TextEditingController _discountController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if (_selectedImages.value.isEmpty) {
              snackBar(
                  content: "Please add at least one image.",
                  context: context);
              return;
            }
            ProductModel product = ProductModel(
              name: _nameController.text,
              subtitle: _subtitleController.text,
              description: _descriptionController.text,
              price: double.parse(_priceController.text),
              stock: int.parse(_stockController.text),
              images: [],
              id: '',
              rate: 0,
              sellerId: '',
              image: '',
              categories: _selectedCategories
                  .map((category) => category.toLowerCase())
                  .toList(),
              date: DateTime.now(),
              reviews: [],
            );
            await BlocProvider.of<ManageProductsCubit>(
                    context)
                .uploadProduct(
                    product: product,
                    selectedImages: _selectedImages.value);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Add Product',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
