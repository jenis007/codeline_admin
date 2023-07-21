import 'package:flutter/material.dart';

import '../../widget/app_color.dart';

class AddDevloperScreen extends StatefulWidget {
  const AddDevloperScreen({Key? key}) : super(key: key);

  @override
  State<AddDevloperScreen> createState() => _AddDevloperScreenState();
}

class _AddDevloperScreenState extends State<AddDevloperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Add Devloper',
              style: TextStyle(
                  color: AppColor.mainColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Divider(
              color: AppColor.grey400,
            ),
          ],
        ),
      ),
    );
  }
}
