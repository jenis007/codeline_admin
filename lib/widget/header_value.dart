import 'package:flutter/material.dart';

import 'common_textStyle.dart';

headingTitle({String? name}) {
  return Expanded(
    child: Container(
      height: 50,
      alignment: Alignment.center,
      child: Text('$name', style: FormTextStyle().k18blackWBold),
    ),
  );
}

valueData({String? name, Color color = Colors.black}) {
  return Expanded(
    child: Container(
      height: 50,
      alignment: Alignment.center,
      child: Text(
        '$name',
        style: TextStyle(fontSize: 15, color: color),
      ),
    ),
  );
}
