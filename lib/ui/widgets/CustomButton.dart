import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/AppColors.dart';

class CustomButton extends StatelessWidget{
  final double height;
  final double width;
  final String text;
  final void Function()? onclick;
  const CustomButton({super.key, required this.height, required this.width, required this.text, this.onclick});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return SizedBox(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: FilledButton(
            onPressed: onclick,
            style: FilledButton.styleFrom(
              backgroundColor: colors.baseColor,
              foregroundColor: colors.onBaseColor,
            ),
            child: Text(text,
              style:TextStyle(
                color: colors.onBaseColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
        ),
      ),

    );
  }

}
