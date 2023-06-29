import 'package:flutter/material.dart';

class ButtonBoxWidget extends StatelessWidget {
  const ButtonBoxWidget({
    super.key,
    required this.iconphoto,
  });
  final IconData? iconphoto;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Icon(iconphoto));
  }
}
