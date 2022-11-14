import 'package:flutter/material.dart';

class StepperData {
  final bool isDone;
  final Widget? title;
  final Widget? content;
  final Widget? iconWidget;

  StepperData({required this.isDone, this.iconWidget, this.title, this.content});
}