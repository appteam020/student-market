import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(BuildContext context, String message, Color color) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
}
