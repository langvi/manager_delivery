import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildTextInput extends StatefulWidget {
  final IconData iconLeading;

  final String hintText;

  final TextEditingController controller;

  final FocusNode currentNode;

  final FocusNode nextNode;

  final bool obscureText;
  final bool isBorderFocus;

  final String isStringEmpty;

  final double borderRadius;
  final Color filledColor;

  final TextInputAction iconNextTextInputAction;

  final Function submitFunc;

  final Function onNext;

  final String Function(String) validator;

  final TextInputType textInputType;

  final int maxLengthInputForm;

  final bool isReadOnly;
  final bool isBorder;
  final List<TextInputFormatter> inputFormatters;

  BuildTextInput({
    @required this.hintText,
    @required this.controller,
    this.currentNode,
    this.iconLeading,
    this.submitFunc,
    this.nextNode,
    this.obscureText = false,
    this.isStringEmpty,
    this.iconNextTextInputAction = TextInputAction.next,
    this.onNext,
    this.validator,
    this.borderRadius = 10.0,
    this.textInputType = TextInputType.text,
    this.maxLengthInputForm,
    this.isReadOnly = false,
    this.inputFormatters,
    this.filledColor = Colors.grey,
    this.isBorder = false,
    this.isBorderFocus = false,
  });

  @override
  _BuildInputTextState createState() => _BuildInputTextState();
}

class _BuildInputTextState extends State<BuildTextInput> {
  // bool _isShowButtonClear = false;
  // bool _autovalidate;
  @override
  void initState() {
    super.initState();
    // _autovalidate = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (v) {
          // if (!_autovalidate) {
          //   setState(() {
          //     _autovalidate = true;
          //   });
          // }

          // if (!_isShowButtonClear || v.isEmpty) {
          //   setState(() {
          //     _isShowButtonClear = v.isNotEmpty;
          //   });
          // }
        },
        textInputAction: widget.iconNextTextInputAction,
        controller: widget.controller,
        obscureText: widget.obscureText,
        focusNode: widget.currentNode,
        keyboardType: widget.textInputType,
        inputFormatters: widget.inputFormatters ?? [],
        readOnly: widget.isReadOnly,
        onFieldSubmitted: (v) {
          if (widget.iconNextTextInputAction.toString() ==
              TextInputAction.next.toString()) {
            FocusScope.of(context).requestFocus(widget.nextNode);
            widget.onNext();
          } else {
            widget.submitFunc();
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.filledColor,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
          hintText: widget.hintText,
          prefixIcon: widget.iconLeading != null
              ? Icon(widget.iconLeading, color: Colors.grey)
              : null,
          prefixStyle:
              TextStyle(color: Colors.red, backgroundColor: Colors.white),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: widget.isBorder
                  ? BorderSide(width: 1, color: Colors.grey)
                  : BorderSide.none),
          contentPadding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}
