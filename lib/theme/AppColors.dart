import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color textColor;
  final Color descColor;
  final Color baseColor;
  final Color cardColor;
  final Color buttonColor;
  final Color backgroundColor;
  final Color onBaseColor;
  final Color iconColor;
  final Color activeColor;
  final Color inactiveColor;
  final Color okBtnColor;
  final Color cancelBtnColor;
  const AppColors({
    required this.textColor,
    required this.descColor,
    required this.baseColor,
    required this.cardColor,
    required this.buttonColor,
    required this.backgroundColor,
    required this.onBaseColor,
    required this.iconColor,
    required this.activeColor,
    required this.inactiveColor,
    required this.okBtnColor,
    required this.cancelBtnColor,
  });

  @override
  AppColors copyWith({
    Color? textColor,
    Color? descColor,
    Color? baseColor,
    Color? cardColor,
    Color? buttonColor,
    Color? backgroundColor,
    Color? onBaseColor,
    Color? iconColor,
    Color? activeColor,
    Color? inactiveColor,
    Color? okBtnColor,
    Color? cancelBtnColor,
  }) {
    return AppColors(
      textColor: textColor ?? this.textColor,
      descColor: descColor ?? this.descColor,
      baseColor: baseColor ?? this.baseColor,
      cardColor: cardColor ?? this.cardColor,
      buttonColor: buttonColor ?? this.buttonColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      onBaseColor: onBaseColor ?? this.onBaseColor,
      iconColor: iconColor ?? this.iconColor,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      okBtnColor: okBtnColor ?? this.okBtnColor,
      cancelBtnColor: cancelBtnColor ?? this.cancelBtnColor
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      textColor: Color.lerp(textColor, other.textColor, t)!,
      descColor: Color.lerp(descColor, other.descColor, t)!,
      baseColor: Color.lerp(baseColor, other.baseColor, t)!,
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      onBaseColor: Color.lerp(onBaseColor, other.onBaseColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      okBtnColor: Color.lerp(okBtnColor, other.okBtnColor, t)!,
      cancelBtnColor: Color.lerp(cancelBtnColor, other.cancelBtnColor, t)!,
    );
  }
}
