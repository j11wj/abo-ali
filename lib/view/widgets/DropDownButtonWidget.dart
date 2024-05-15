import 'package:flutter/material.dart';

class DropDownButtonWidget extends StatefulWidget {
  const DropDownButtonWidget({
    super.key,
    required this.list,
    required this.hint,
  });
  final List<String> list;
  static String retvalue = '';

  final String hint;

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  String? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: double.infinity,
        width: double.infinity,
        child: DropdownButton(
          items: widget.list
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ))
              .toList(),
          onChanged: (val) {
            setState(() {
              value = val.toString();
              DropDownButtonWidget.retvalue = value!;
            });
          },
          value: value,
          hint: Text(
            widget.hint,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          iconDisabledColor: Colors.black,
          iconEnabledColor: Colors.black,
        ),
      ),
    );
  }
}
