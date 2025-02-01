import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internship_task/res/colors.dart';
import 'package:internship_task/utils/utils.dart';

class InputTextfield extends StatelessWidget {
  Color borderColor;
  String hintText;
  String label;
  double? fieldFontSize;
  TextEditingController? editController;
  FocusNode currentFocus;
  FocusNode nextFocus;
  VoidCallback? onExit;
  Widget? customPrefixIcon;
  Color? prefixIconColor;
  Widget? customSuffixIcon;
  Color? suffixIconColor;
  VoidCallback? customOnTap;
  InputTextfield(
      {super.key,
      required this.borderColor,
      required this.hintText,
      required this.label,
      this.fieldFontSize,
      this.editController,
      required this.currentFocus,
      required this.nextFocus,
      this.customPrefixIcon,
      this.prefixIconColor,
      this.customSuffixIcon,
      this.suffixIconColor,
      this.customOnTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
      child: TextFormField(
        controller: editController,
        onFieldSubmitted: (value) {
          // on field exits focus will be transfer to next text form field
          Utils.focusChanger(currentFocus, nextFocus, context);
        },
        focusNode: currentFocus,
        decoration: InputDecoration(
            hintText: hintText,
            label: Text(
              label,
              style: TextStyle(
                  fontSize: fieldFontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black),
            ),
            hintStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: fieldFontSize),
            filled: true,
            // sets the background color of textformfield to white
            fillColor: AppColor.white,
            prefixIcon: customPrefixIcon,
            prefixIconColor: prefixIconColor,
            suffixIcon: customSuffixIcon,
            suffixIconColor: suffixIconColor,
            alignLabelWithHint: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: borderColor),
              borderRadius: BorderRadius.circular(5),
            )),
      ),
    );
  }
}
