import 'package:flutter/material.dart';

import '../../widget/app_color.dart';

class DevloperScreen extends StatefulWidget {
  const DevloperScreen({Key? key}) : super(key: key);

  @override
  State<DevloperScreen> createState() => _DevloperScreenState();
}

class _DevloperScreenState extends State<DevloperScreen> {
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
            Row(
              children: [
                Text(
                  'Devloper',
                  style: TextStyle(
                      color: AppColor.mainColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 20,
                ),
                Transform.rotate(
                  angle: 1.555,
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Divider(
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: TextEditingController(),
                      onChanged: (val) {
                        // controller.getSearchData(val);
                      },
                      cursorColor: AppColor.mainColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: AppColor.grey400),
                        hintText: 'Search here....',
                      ),
                    ),
                  ),
                )
              ],
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
