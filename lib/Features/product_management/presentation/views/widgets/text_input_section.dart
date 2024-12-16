import 'package:flutter/material.dart';
import 'package:online_shopping/Features/product_management/presentation/views/widgets/product_custom_text_field.dart';

class TextInputSection extends StatelessWidget {
  const TextInputSection({
    super.key,
    required TextEditingController nameController,
    required TextEditingController subtitleController,
    required TextEditingController descriptionController,
    required TextEditingController priceController,
    required TextEditingController stockController,
    required TextEditingController priceAfterDiscountController,
    required TextEditingController discountController,
  })  : _priceAfterDiscountController = priceAfterDiscountController,
        _discountController = discountController,
        _nameController = nameController,
        _subtitleController = subtitleController,
        _descriptionController = descriptionController,
        _priceController = priceController,
        _stockController = stockController;

  final TextEditingController _nameController;
  final TextEditingController _subtitleController;
  final TextEditingController _descriptionController;
  final TextEditingController _priceController;
  final TextEditingController _stockController;
  final TextEditingController _priceAfterDiscountController;
  final TextEditingController _discountController;
  @override
  Widget build(BuildContext context) {
    return Column(
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
        Row(
          children: [
            Expanded(
              child: ProductCustomTextField(
                label: "Price",
                controller: _priceController,
                prefixIcon: const Icon(Icons.attach_money),
                validate: true,
                isNumber: true,
                isDecimal: true,
                onChange: (value) {
                  double price = double.tryParse(value) ?? 0.0;
                  int discountPercent = int.tryParse(_discountController.text) ?? 0;
                  double discountedPrice = price - (price * (discountPercent / 100));
                  _priceAfterDiscountController.text = discountedPrice.toStringAsFixed(2);
                },
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
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: ProductCustomTextField(
                label: "After Sale",
                controller: _priceAfterDiscountController,
                prefixIcon: const Icon(Icons.attach_money),
                validate: true,
                isNumber: true,
                isDecimal: true,
                enabled: false,
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
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ProductCustomTextField(
                label: "Discount Percentage",
                controller: _discountController,
                prefixIcon: const Icon(Icons.percent),
                validate: true,
                isNumber: true,
                onChange: (value) {
                  double discountPercent = double.tryParse(value) ?? 0.0;
                  double price = double.tryParse(_priceController.text) ?? 0;
                  double discountedPrice = price - (price * (discountPercent / 100));
                  _priceAfterDiscountController.text = discountedPrice.toStringAsFixed(2);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the discount percentage';
                  }
                  if (int.parse(value) > 100) {
                    return 'Discount percentage should not be more than 100';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ProductCustomTextField(
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
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
