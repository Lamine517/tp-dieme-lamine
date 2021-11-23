// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todoapp/common/common.dart';

class MenuItem extends StatelessWidget {
  final String menuItemText;
  final IconData menuItemIcon;

  const MenuItem({ Key? key, 
    required this.menuItemText, 
    required this.menuItemIcon 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            menuItemIcon,
            color: Colors.white.withOpacity(.3)
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            menuItemText,
            style: TextStyle(
              fontFamily: regularFont,
              color: Colors.white.withOpacity(.9)
            ),
          )
        ],
      ),
    );
  }
}