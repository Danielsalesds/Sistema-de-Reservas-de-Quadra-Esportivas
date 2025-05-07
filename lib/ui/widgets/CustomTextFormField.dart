import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget{
  final String label;
  final String? Function(String?)? validateFunction;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CustomTextFormField({super.key, required this.label, this.validateFunction, this.controller, this.keyboardType});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          validator: validateFunction,
          style:TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.secondary,
          ),
          decoration: InputDecoration(
            labelText: label,
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
          )
      ),
    );
  }}