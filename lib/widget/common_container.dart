import 'package:flutter/material.dart';

import 'app_color.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({Key? key, this.child}) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 53,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.grey400,
          ),
        ),
        child: child);
  }
}
