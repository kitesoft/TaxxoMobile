import 'package:flutter/material.dart';


class DisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}