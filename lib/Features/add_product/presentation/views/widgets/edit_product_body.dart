import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/add_product/presentation/manger/manage_products/manage_products_cubit.dart';
import 'package:online_shopping/Features/add_product/presentation/views/widgets/categories_gridview.dart';
import 'package:online_shopping/Features/add_product/presentation/views/widgets/submit_button.dart';
import 'package:online_shopping/Features/add_product/presentation/views/widgets/text_input_section.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/presentation/views/navigation_bar_view.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

class EditProductBody extends StatefulWidget {
  const EditProductBody({super.key, required this.product});
  final Product product;
  @override
  State<EditProductBody> createState() => _EditProductBodyState();
}

class _EditProductBodyState extends State<EditProductBody> {
  late TextEditingController _nameController;
  late TextEditingController _subtitleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late TextEditingController _discountController;
  late TextEditingController _priceAfterDiscountController;
  final _formKey = GlobalKey<FormState>();
  // final ValueNotifier<List<File>> _selectedImages =
  //     ValueNotifier<List<File>>([]);

  final Set<String> _selectedCategories = {};
  @override
  void initState() {
    _priceAfterDiscountController = TextEditingController(text: '${widget.product.priceBeforeDiscount}');
    _discountController = TextEditingController(text: '${(widget.product.discount * 100).toInt()}');
    _stockController = TextEditingController(text: '${widget.product.stock}');
    _priceController = TextEditingController(text: '${widget.product.price}');
    _descriptionController = TextEditingController(text: widget.product.description);
    _subtitleController = TextEditingController(text: widget.product.subtitle);
    _nameController = TextEditingController(text: widget.product.name);
    _selectedCategories.addAll(widget.product.categories);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _subtitleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _editProduct() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategories.isEmpty) {
        snackBar(content: "Please add at least one Category.", context: context);
        return;
      }

      ProductModel product = getProductModel();
      await BlocProvider.of<ManageProductsCubit>(context).editProduct(product: product);
    }
  }

  void _deleteProduct() async {
    ProductModel product = getProductModel();
    await BlocProvider.of<ManageProductsCubit>(context).deleteProduct(product: product);
  }

  ProductModel getProductModel() {
    return ProductModel(
      name: _nameController.text,
      subtitle: _subtitleController.text,
      description: _descriptionController.text,
      priceBeforeDiscount: double.parse(_priceController.text),
      price: double.parse(_priceAfterDiscountController.text),
      stock: int.parse(_stockController.text),
      images: widget.product.images,
      id: widget.product.id,
      rate: widget.product.rate,
      sellerId: widget.product.sellerId,
      image: widget.product.image,
      categories: _selectedCategories.map((category) => category.toLowerCase()).toList(),
      date: widget.product.date,
      reviews: widget.product.reviews,
      discount: double.parse(_discountController.text) / 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageProductsCubit, ManageProductsState>(
      listener: (context, state) async {
        if (state is AddProductsFailed) {
          snackBar(
            content: Text(state.error),
            context: context,
          );
        } else if (state is AddProductsSucsses) {
          snackBar(content: 'Changes saved successfully', context: context, color: Colors.green);
          await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const NavigationBarView(),
            ),
            (Route<dynamic> route) => false,
          );
          setState(() {});
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AddProductsLoading,
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Edit Product'),
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
                          // ImageSelector(selectedImages: _selectedImages),
                          const SizedBox(height: 24),
                          EditsButton(
                            onPressed: _editProduct,
                            title: 'Edit Product',
                          ),
                          const SizedBox(height: 24),
                          EditsButton(
                            onPressed: _deleteProduct,
                            color: Colors.red,
                            title: 'Delete Product',
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
