// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todoapp/common/common.dart';
import 'package:todoapp/common/menu_item.dart';

class MenuScreen extends StatefulWidget {
  final VoidCallback onMenuClose;
  final double screenWidth, screenHeight;
  
  const MenuScreen({ Key? key, required this.onMenuClose, required this.screenWidth, required this.screenHeight }) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primaryBackground,
      body: Container(
        width: widget.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: .3 * widget.screenWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: widget.onMenuClose,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(.4), width: 1.5),
                        shape: BoxShape.circle
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: .05 * widget.screenHeight),
              child: Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                  color: businessIndicator,
                  shape: BoxShape.circle
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: primaryBackground,
                      shape: BoxShape.circle
                    ),
                    child: CircleAvatar(
                      foregroundImage: AssetImage("assets/images/avatar.jpg"),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: .04 * widget.screenHeight),
              child: Text(
                "Olivia\nMitchell",
                style: TextStyle(
                  fontFamily: boldFont,
                  fontSize: 35,
                  color: Colors.white.withOpacity(.8)
                ),
              ),
            ),
            MenuItem(menuItemText: "Templates", menuItemIcon: Icons.bookmark_border_outlined),
            MenuItem(menuItemText: "Categories", menuItemIcon: Icons.grid_view_outlined),
            MenuItem(menuItemText: "Analytics", menuItemIcon: Icons.pie_chart_outline),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Designed by\n",
                          style: TextStyle(
                            fontFamily: regularFont,
                            fontSize: 14,
                            color: thirdFontColor
                          )
                        ),
                        TextSpan(
                          text: "Alex Arutuynov",
                          style: TextStyle(
                            fontFamily: boldFont,
                            fontSize: 18,
                            color: Colors.white
                          )
                        )
                      ]
                    )
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}