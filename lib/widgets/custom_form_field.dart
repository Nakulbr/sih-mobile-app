import 'package:flutter/material.dart';
import 'package:sih_hackathon/constants/custom_font_weight.dart';

enum CustomFormFieldInputType { date, select, text }

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    this.isPassword = false,
    this.inputType = CustomFormFieldInputType.text,
    this.selectOptions = const [],
    required this.textEditingController,
    required this.textInputType,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
  });

  final bool isPassword;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final CustomFormFieldInputType inputType;
  final List<String>? selectOptions;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = true;
  final Color _baseColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    switch (widget.inputType) {
      case CustomFormFieldInputType.text:
        return TextFormField(
          obscureText: widget.isPassword ? _obscureText : false,
          controller: widget.textEditingController,
          keyboardType: widget.textInputType,
          cursorColor: _baseColor,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: _baseColor,
              fontWeight: CustomFontWeight.normal,
            ),
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: _baseColor,
              fontWeight: CustomFontWeight.normal,
            ),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: _baseColor,
            ),
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: _baseColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
              gapPadding: 10,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _baseColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
              gapPadding: 10,
            ),
            focusColor: _baseColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _baseColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
              gapPadding: 10,
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: CustomFontWeight.normal,
          ),
        );
      case CustomFormFieldInputType.date:
        return GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              setState(() {
                widget.textEditingController.text =
                    "${pickedDate.toLocal()}".split(' ')[0];
              });
            }
          },
          child: AbsorbPointer(
            child: TextFormField(
              controller: widget.textEditingController,
              keyboardType: TextInputType.none, // Prevent keyboard pop-up
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: _baseColor,
                  fontWeight: CustomFontWeight.normal,
                ),
                labelText: widget.labelText,
                labelStyle: TextStyle(
                  color: _baseColor,
                  fontWeight: CustomFontWeight.normal,
                ),
                prefixIcon: Icon(widget.prefixIcon, color: _baseColor),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: _baseColor, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  gapPadding: 10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _baseColor, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  gapPadding: 10,
                ),
                focusColor: _baseColor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _baseColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  gapPadding: 10,
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: CustomFontWeight.normal,
              ),
            ),
          ),
        );
      case CustomFormFieldInputType.select:
        return DropdownButtonFormField<String>(
          value: widget.textEditingController.text.isEmpty
              ? null
              : widget.textEditingController.text,
          items: widget.selectOptions?.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              widget.textEditingController.text = newValue ?? '';
            });
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: _baseColor,
              fontWeight: CustomFontWeight.normal,
            ),
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: _baseColor,
              fontWeight: CustomFontWeight.normal,
            ),
            prefixIcon: Icon(widget.prefixIcon, color: _baseColor),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: _baseColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
              gapPadding: 10,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _baseColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
              gapPadding: 10,
            ),
            focusColor: _baseColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _baseColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
              gapPadding: 10,
            ),
          ),
          style: TextStyle(
            fontSize: 16,
            fontWeight: CustomFontWeight.normal,
            color: _baseColor,
          ),
        );
    }
  }
}
