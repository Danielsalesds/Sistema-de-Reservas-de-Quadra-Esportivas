import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
void showErrorDialog(BuildContext context, String msg) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.scale,
    title: "Erro!",
    desc: msg,
    btnOkText: "Ok",
    btnOkColor: Theme.of(context).colorScheme.primary,
    btnOkOnPress: () {},
    titleTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
        fontSize: 22
    ),
    descTextStyle: TextStyle(
      fontSize: 16,
      color: Theme.of(context).colorScheme.tertiary,
    ),
  ).show();
}