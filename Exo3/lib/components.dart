import 'package:flutter/material.dart';
import 'package:exo3/consts.dart';

class MyPadding extends Padding {
  const MyPadding({super.key, required super.child}): super(padding: defaultPadding);
}

class MyText extends Text {
  const MyText(super.data, {super.key}): super(style: defaultTextStyle);
}

class MySizedBox extends SizedBox {
  const MySizedBox({super.key, required super.child}): super(width: 100);
}