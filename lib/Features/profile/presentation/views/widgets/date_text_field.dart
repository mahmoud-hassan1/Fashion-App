import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/get_date.dart';

class DateTextField extends StatelessWidget {
  const DateTextField({super.key, required this.onDateChanged, required this.initialDate});

  final void Function(DateTime date) onDateChanged;
  final DateTime initialDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            maxLines: 1,
            enabled: false,
            controller: TextEditingController(text: getDate(initialDate)),
            decoration: const InputDecoration(labelText: 'Date'),
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () async {
            DateTime? res = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              initialEntryMode: DatePickerEntryMode.calendarOnly,
            );

            if (res != null) {
              onDateChanged(res);
            }
          },
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}
