import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showSucessDialog(BuildContext context, msg) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.scale,
    title: "Sucesso!",
    desc: msg,
    btnOkText: "Ok",
    btnOkColor: Theme.of(context).colorScheme.primary,
    btnOkOnPress: () {
      Navigator.pop(context);
    },
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
  void showSucessDialog2(BuildContext context, msg, void Function()? onclick) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: "Sucesso!",
      desc: msg,
      btnOkText: "Ok",
      btnOkColor: Theme.of(context).colorScheme.primary,
      btnOkOnPress: () {
        if (onclick != null) {
          onclick();
        }
      },
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
