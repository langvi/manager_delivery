import 'package:flutter/material.dart';
import 'package:manage_delivery/base/consts/colors.dart';

Widget buildDropDown({
  @required List<String> values,
  @required String hintText,
  @required String currentValue,
  bool isColorWhite = false,
  Function(String) onChange,
}) {
  return DropdownButton<String>(
    isExpanded: true,
    hint: Text(
      hintText,
      style: TextStyle(color: Colors.grey),
    ),
    underline: Container(),
    dropdownColor: isColorWhite ? AppColors.mainColor : Colors.white,
    value: currentValue.isEmpty ? null : currentValue,
    iconEnabledColor: isColorWhite ? Colors.white : AppColors.mainColor,
    onChanged: onChange,
    items: values.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: TextStyle(color: isColorWhite ? Colors.white : Colors.black),
          // style: TextStyle(fontSize: sizeText, color: colorValue),
        ),
      );
    }).toList(),
  );
}
