import 'package:flutter/material.dart';
import 'package:online_shopping/core/widgets/custtom_text_field.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

// ignore: must_be_immutable
class DateOfBirth extends StatefulWidget {
  DateOfBirth({super.key, required this.dateTime, required this.onChanged});

  DateTime dateTime;
  final void Function(DateTime date) onChanged;

  @override
  State<DateOfBirth> createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: "Date of Birth",
            controller: TextEditingController(text: "${widget.dateTime.day}-${widget.dateTime.month}-${widget.dateTime.year}"),
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
              currentDate: DateTime.now(),
              lastDate: DateTime(5000),
            );

            if (res == null) {
              if (context.mounted) {
                snackBar(content: "Enter your date of birth", context: context);
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
