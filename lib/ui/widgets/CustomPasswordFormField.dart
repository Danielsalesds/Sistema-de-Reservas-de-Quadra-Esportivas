import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatefulWidget {
  final String labelText;
  final String? Function(String?)? validateFunction;
  final TextEditingController? controller;

  const CustomPasswordFormField({
    super.key,
    required this.labelText,
    this.validateFunction,
    this.controller,
  });

  @override
  State<CustomPasswordFormField> createState() => _CustomPassordFormFieldState();
}

class _CustomPassordFormFieldState extends State<CustomPasswordFormField> {
  late bool obscured = true;

  @override
  void initState() {
    super.initState();
    obscured = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validateFunction,
        obscureText: obscured,
        style:TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Theme.of(context).colorScheme.secondary,
        ),
        decoration: InputDecoration(
          suffixIconColor:  Theme.of(context).colorScheme.primary,
          suffixIcon: GestureDetector(
            onTap: () => {
              setState(() {
                obscured = !obscured;
              })
            },
            child:
                obscured
                  ? const Icon(Icons.remove_red_eye_rounded,)
                  : const Icon(Icons.remove_red_eye_outlined),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w500
          ),
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 3), // Linha quando não está focado
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary, width: 3), // Linha quando focado
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 3), // Linha quando há erro
          ),
        ),
      ),
    );
  }
}