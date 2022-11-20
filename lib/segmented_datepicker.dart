library segmented_datepicker;

import 'package:flutter/material.dart';
import 'package:segmented_datepicker/utils/extensions.dart';

class SegmentedDatepicker extends StatefulWidget {
  late final TextEditingController controller;
  late final bool showOutput;

  SegmentedDatepicker({
    super.key,
    TextEditingController? controller,
    this.showOutput = true,
  }) {
    this.controller = controller ?? TextEditingController();
  }

  @override
  State<SegmentedDatepicker> createState() => _SegmentedDatepickerState();
}

class _SegmentedDatepickerState extends State<SegmentedDatepicker> {
  DateTime date = DateTime(2000);

  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();

  final _dayFocusNode = FocusNode();
  final _monthFocusNode = FocusNode();
  final _yearFocusNode = FocusNode();

  final separator = '/';

  void setDate(String day) {
    date = date.copyWith(day: int.tryParse(day) ?? 0);
    widget.controller.text = date.toString();

    if (day.length == 2) {
      _dayFocusNode.unfocus();
      _monthFocusNode.requestFocus();
    }
  }

  void setMonth(String month) {
    date = date.copyWith(month: int.tryParse(month) ?? 0);
    widget.controller.text = date.toString();

    if (month.length == 2) {
      _monthFocusNode.unfocus();
      _yearFocusNode.requestFocus();
    }
  }

  void setYear(String year) {
    if (year.length > 4) {
      _yearController.text = year.substring(0, 5);
      return;
    }

    date = date.copyWith(year: int.tryParse(year) ?? 0);
    widget.controller.text = date.toString();
  }

  /// utilities

  /// allows a maximum of [count] characters
  String limitCharacter(String text, {int count = 2}) {
    if (text.length < count) return text;
    return text.substring(0, count + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: _dayController,
            focusNode: _dayFocusNode,
            keyboardType: TextInputType.datetime,
            onChanged: setDate,
            textInputAction: TextInputAction.next,
          ),
        ),
        Text(separator),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: _monthController,
            focusNode: _monthFocusNode,
            keyboardType: TextInputType.datetime,
            onChanged: setMonth,
            textInputAction: TextInputAction.next,
          ),
        ),
        Text(separator),
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: _yearController,
            focusNode: _yearFocusNode,
            keyboardType: TextInputType.datetime,
            onChanged: setYear,
            textInputAction: TextInputAction.done,
          ),
        ),
        const SizedBox(width: 12),
        if (widget.showOutput) Text("($date)")
      ],
    );
  }
}
