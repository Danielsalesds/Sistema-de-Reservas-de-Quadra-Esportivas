import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

void mostrarAlertaTopo(String mensagem, {Color cor = Colors.green}) {
  showSimpleNotification(
    Text(
      mensagem,
      style: TextStyle(color: Colors.white),
    ),
    background: cor,
    position: NotificationPosition.top,
    duration: Duration(seconds: 3),
    elevation: 6,
  );
}
