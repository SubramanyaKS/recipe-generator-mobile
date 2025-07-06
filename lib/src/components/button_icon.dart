import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({super.key, required this.onPress, this.backgroundColor, this.foregroundColor, required this.icon, required this.width, required this.height});

  final VoidCallback onPress;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData icon;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: backgroundColor?? Colors.grey, // Button color
        child: InkWell(
          splashColor: Colors.red, // Splash color
          onTap:  onPress,
          child: SizedBox(width: width, height: height, child: Icon(icon,color: foregroundColor!=null?foregroundColor:Colors.grey.shade200,)),
        ),
      ),
    );
  }
}
