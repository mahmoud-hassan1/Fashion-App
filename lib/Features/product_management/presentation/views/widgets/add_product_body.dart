import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/product_management/presentation/manger/manage_products/manage_products_cubit.dart';
import 'package:online_shopping/Features/product_management/presentation/views/widgets/categories_gridview.dart';
import 'package:online_shopping/Features/product_management/presentation/views/widgets/image_selector.dart';
import 'package:online_shopping/Features/product_management/presentation/views/widgets/submit_button.dart';
import 'package:online_shopping/Features/product_management/presentation/views/widgets/text_input_section.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/Features/home/presentation/views/navigation_bar_view.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';
import 'dart:io';

class AddProductBody extends StatefulWidget {
  const AddProductBody({super.key});

  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _priceAfterDiscountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<List<File>> _selectedImages = ValueNotifier<List<File>>([]);

  final Set<String> _selectedCategories = {};

  @override
  void dispose() {
    _nameController.dispose();
    _subtitleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _selectedImages.dispose();
    super.dispose();
  }

  void _addProduct() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedImages.value.isEmpty) {
        snackBar(content: "Please add at least one image.", context: context);
        return;
      }
      if (_selectedCategories.isEmpty) {
        snackBar(content: "Please add at least one Category.", context: context);
        return;
      }
      ProductModel product = ProductModel(
          name: _nameController.text,
          subtitle: _subtitleController.text,
          description: _descriptionController.text,
          priceBeforeDiscount: double.parse(_priceController.text),
          price: double.parse(_priceAfterDiscountController.text),
          stock: int.parse(_stockController.text),
          images: [],
          id: '',
          rate: 0,
          sellerId: '',
          image: '',
          categories: _selectedCategories.map((category) => category.toLowerCase()).toList(),
          date: DateTime.now(),
          reviews: [],
          discount: double.parse(_discountController.text) / 100);
      await BlocProvider.of<ManageProductsCubit>(context).addProduct(product: product, selectedImages: _selectedImages.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageProductsCubit, ManageProductsState>(
      listener: (context, state) {
        if (state is AddProductsFailed) {
          snackBar(
            content: Text(state.error),
            context: context,
          );
        } else if (state is AddProductsSucsses) {
          snackBar(content: 'Product added successfully', context: context, color: Colors.green);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationBarView(),
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AddProductsLoading,
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Add Product'),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextInputSection(
                            nameController: _nameController,
                            subtitleController: _subtitleController,
                            descriptionController: _descriptionController,
                            priceController: _priceController,
                            stockController: _stockController,
                            discountController: _discountController,
                            priceAfterDiscountController: _priceAfterDiscountController,
                          ),
                          CategoriesGridview(selectedCategories: _selectedCategories),
                          const SizedBox(
                            height: 16,
                          ),
                          ImageSelector(selectedImages: _selectedImages),
                          const SizedBox(height: 24),
                          EditsButton(
                            onPressed: _addProduct,
                            title: 'Add Product',
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
