import 'package:flutter/material.dart';

class InputDropDown extends StatefulWidget {
  final TextEditingController controller;
  final double? fontSize;
  final double? borderRadius;
  final validator;
  final List<String> list;
  const InputDropDown({
    super.key,
    required this.controller,
    this.fontSize = 16,
    this.borderRadius = 10,
    this.validator,
    required this.list,
  });

  @override
  State<InputDropDown> createState() => _InputDropDownState();
}

class _InputDropDownState extends State<InputDropDown> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.list[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.list[0],
      items: widget.list.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(value, style: TextStyle(fontSize: widget.fontSize, color: Colors.grey)),
          ),
        );
      }).toList(),
      onChanged: (value) {
        widget.controller.text = value.toString();
      },
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: widget.fontSize,
        ),
        hintStyle: TextStyle(
          fontSize: widget.fontSize,
          color: Colors.grey,
          fontFamily: 'TTNorms_Regular',
        ),
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadius!),
          ),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadius!),
          ),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadius!),
          ),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadius!),
          ),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        errorStyle: const TextStyle(
          fontSize: 12,
          color: Colors.blue,
          fontFamily: 'TTNorms_Medium',
        ),
      ),
    );
  }
}
