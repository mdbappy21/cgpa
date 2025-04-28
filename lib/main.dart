import 'package:cgpa/controller_binder.dart';
import 'package:flutter/material.dart';
import 'package:cgpa/app.dart';

void main() {
  ControllerBinder().dependencies();
  runApp(const DiuCgpa());
}