import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/add_product/presentation/manger/manage_products/manage_products_cubit.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/Features/home/presentation/views/navigation_bar_view.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/product_custom_text_field.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<List<File>> _selectedImages =
      ValueNotifier<List<File>>([]);
  final ImagePicker _imagePicker = ImagePicker();
  final Set<String> _selectedCategories = {};

  final List<String> _categories = [
    "Men",
    "Women",
    "Kids",
    "Shoes",
    "Accessories",
    "Clothes"
  ];

  Future<void> _pickImage() async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _selectedImages.value = [..._selectedImages.value, File(image.path)];
      }
    } else if (status.isDenied) {
      snackBar(
          content: "Permission denied. Please allow access to continue.",
          context: context);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void _toggleCategorySelection(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  void _removeImage(int index) {
    _selectedImages.value = List<File>.from(_selectedImages.value)
      ..removeAt(index);
  }

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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Add Product'),
        ),
        BlocConsumer<ManageProductsCubit, ManageProductsState>(
          listener: (context, state) {
            if (state is AddProductsFailed) {
              snackBar(
                content: Text(state.error),
                context: context,
              );
            }
            else if(state is AddProductsSucsses){
              snackBar(
                content:'Product added successfully',
                context: context,
                color: Colors.green
              );
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavigationBarView(),));
            }
          },
          builder: (context, state) {
            return SliverList(
              delegate: SliverChildListDelegate([
                ModalProgressHUD(
                  inAsyncCall: state is AddProductsLoading,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          ProductCustomTextField(
                            label: "Name",
                            controller: _nameController,
                            prefixIcon: const Icon(Icons.edit),
                            validate: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          ProductCustomTextField(
                            label: "Subtitle",
                            controller: _subtitleController,
                            validate: true,
                            prefixIcon: const Icon(Icons.short_text),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product subtitle';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          ProductCustomTextField(
                            label: "Description",
                            controller: _descriptionController,
                            prefixIcon: const Icon(Icons.description_outlined),
                            expand: true,
                            validate: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          ProductCustomTextField(
                            label: "Price",
                            controller: _priceController,
                            prefixIcon: const Icon(Icons.attach_money),
                            validate: true,
                            isNumber: true,
                            isDecimal: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product price';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          ProductCustomTextField(
                            label: "Stock",
                            controller: _stockController,
                            prefixIcon: const Icon(Icons.inventory_2_outlined),
                            validate: true,
                            isNumber: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter stock quantity';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: _categories.length,
                            itemBuilder: (context, index) {
                              final category = _categories[index];
                              final isSelected =
                                  _selectedCategories.contains(category);
                              return GestureDetector(
                                onTap: () => _toggleCategorySelection(category),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isSelected
                                            ? Theme.of(context).primaryColor
                                            : Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white),
                                  alignment: Alignment.center,
                                  child: Text(category,
                                      style: Styles.kSmallTextStyle(context)
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Product Images (Max 4)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ValueListenableBuilder<List<File>>(
                                  valueListenable: _selectedImages,
                                  builder: (context, images, _) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 120,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: images.length +
                                                (images.length < 4 ? 1 : 0),
                                            itemBuilder: (context, index) {
                                              if (index == images.length) {
                                                return GestureDetector(
                                                  onTap: _pickImage,
                                                  child: Container(
                                                    width: 120,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .add_photo_alternate_outlined,
                                                      size: 40,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                );
                                              }
                                              return Stack(
                                                children: [
                                                  Container(
                                                    width: 120,
                                                    height: 120,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      image: DecorationImage(
                                                        image: FileImage(
                                                            images[index]),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 4,
                                                    right: 12,
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          _removeImage(index),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: const Icon(
                                                          Icons.close,
                                                          size: 20,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (_selectedImages.value.isEmpty) {
                                    snackBar(
                                        content:
                                            "Please add at least one image.",
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
                                    categories: _selectedCategories.toList(),
                                    date: DateTime.now(),
                                    reviews: [],
                                  );
                                  await BlocProvider.of<ManageProductsCubit>(
                                          context)
                                      .uploadProduct(
                                          product: product,
                                          selectedImages:
                                              _selectedImages.value);
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            );
          },
        ),
      ],
    );
  }
}
