import 'package:flutter/material.dart';

import '../color.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: MediaQuery.of(context).size.height * .06,
      decoration: BoxDecoration(
          color: MainColor.secondaryColor,
          borderRadius: BorderRadius.circular(15)),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context).textTheme.subtitle1
          )),
    );
  }
}
