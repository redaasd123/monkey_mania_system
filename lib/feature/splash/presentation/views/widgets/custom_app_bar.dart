import 'package:flutter/material.dart';

import '../../../../../core/utils/constans.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
    title: Row(
    mainAxisAlignment: MainAxisAlignment.end, // يخلي الصورة على الشمال
    children: [
    CircleAvatar(
    backgroundImage: AssetImage(kTest),
    backgroundColor: Colors.transparent,
    radius: 20,

    ),
    ],
    ),
    leading: IconButton(onPressed: (){},
    icon: Icon(
    color: Colors.white,
    Icons.menu)),
    elevation: 0,
    backgroundColor: Colors.white,
    );
  }
}
