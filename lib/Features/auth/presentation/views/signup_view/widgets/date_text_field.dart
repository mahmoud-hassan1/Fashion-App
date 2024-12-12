import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/get_date.dart';
import 'package:online_shopping/core/widgets/custtom_text_field.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

// ignore: must_be_immutable
class DateTextField extends StatefulWidget {
  DateTextField({super.key, required this.dateTime, required this.onChanged, required this.label});

  DateTime dateTime;
  final void Function(DateTime date) onChanged;
  final String label;

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: widget.label,
            controller: TextEditingController(text: getDate(widget.dateTime)),
            prefixIcon: const Icon(Icons.calendar_month),
            enabled: false,
          ),
        ),
        const SizedBox(width: 15),
        IconButton(
          onPressed: () async {
            DateTime? res = await showDatePicker(
              context: context,
              firstDate: DateTime(999),
              // currentDate: widget.dateTime,
              initialDate: widget.dateTime,
              lastDate: DateTime(5000),
            );

            if (res == null) {
              if (context.mounted) {
                snackBar(content: "Enter date", context: context);
              }
            } else {
              widget.onChanged(res);
              widget.dateTime = res;
              setState(() {});
            }
          },
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}
