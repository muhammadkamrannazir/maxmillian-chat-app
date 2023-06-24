import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String? labelText;
  TextInputType? keyboardType;
  bool? autocorrect;
  TextCapitalization? textCapitalization;
  bool? obscureText;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;
  bool enableSuggestions;
  CustomTextField({
    this.labelText,
    this.keyboardType,
    this.autocorrect,
    this.textCapitalization,
    this.obscureText,
    this.validator,
    this.onSaved,
    this.enableSuggestions = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText ?? '',
      ),
      keyboardType: keyboardType,
      autocorrect: autocorrect ?? false,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      obscureText: obscureText ?? false,
      validator: validator,
      onSaved: onSaved,
      enableSuggestions: enableSuggestions,
    );
  }
}
