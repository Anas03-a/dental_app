import 'package:flutter/material.dart';

final ValueNotifier<bool> isArabicNotifier = ValueNotifier<bool>(false);

String t(String en, String ar) {
  return isArabicNotifier.value ? ar : en;
}
