// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todoapp/common/common.dart';
import 'package:todoapp/common/slider_item.dart';
import 'package:todoapp/common/task_item.dart';
import 'package:todoapp/models/category.dart';
import 'package:todoapp/models/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


Future<dynamic> _fetchTasks() {
  return http.get(tasksListURL);
}

class HomeScreen extends StatefulWidget {
  final Duration duration;
  final bool isClosed;
  final double screenWidth, screenHeight;
  final AnimationController animationController;
  final Animation<double> scaleAnimation;
  final VoidCallback onMenuClose;

  const HomeScreen({
    Key? key,
    required this.duration,
    required this.isClosed,
    required this.screenWidth,
    required this.screenHeight,
    required this.animationController,
    required this.scaleAnimation,
    required this.onMenuClose,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var tasks = <TaskItem>[];
    
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: widget.isClosed ? 0 : 0.7 * widget.screenWidth,
      right: widget.isClosed ? 0 : -widget.screenWidth,
      duration: widget.duration,
      child: ScaleTransition(
        scale: widget.scaleAnimation,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: businessIndicator,
            child: Icon(
              Icons.add,
            ),
          ),
          body: Container(
            width: widget.screenWidth,
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: secondBackground,
              borderRadius: widget.isClosed
                  ? null
                  : BorderRadius.all(Radius.circular(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: widget.onMenuClose,
                        icon: Icon(
                          Icons.menu,
                          color: thirdFontColor.withOpacity(.5),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              color: thirdFontColor.withOpacity(.5),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications_outlined,
                              color: thirdFontColor.withOpacity(.5),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: _fetchTasks(),
                    builder: (BuildContext context, AsyncSnapshot snapShot) {
                  if (snapShot.hasData) {
                    if (snapShot.data.statusCode == 200) {
                      for (var item
                            in convert.jsonDecode(snapShot.data.body)) {
                          tasks.add(TaskItem(task: Task.fromJson(item)));
                        }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              "What's up, Olivia!",
                              style: TextStyle(
                                  fontFamily: boldFont,
                                  fontSize: 40,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              "CATEGORIES",
                              style: TextStyle(
                                color: thirdFontColor.withOpacity(0.6),
                                fontFamily: regularFont,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            height: 150,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                SliderItem(
                                  category: "Business",
                                  tasksCount: 40,
                                  indicatorColor: businessIndicator,
                                  screenWidth: widget.screenWidth,
                                  terminationPercentage: .6,
                                ),
                                SliderItem(
                                  category: "Personal",
                                  tasksCount: 18,
                                  indicatorColor: personalIndicator,
                                  screenWidth: widget.screenWidth,
                                  terminationPercentage: .4,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              "TASKS",
                              style: TextStyle(
                                color: thirdFontColor.withOpacity(0.6),
                                fontFamily: regularFont,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            height: .45 * widget.screenHeight,
                            child: ListView(
                              padding: EdgeInsets.all(0),
                              children: tasks,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text('Request failed with status: ${snapShot.data.statusCode}.',),
                      );
                    }
                  } else if (snapShot.hasError) {
                      return SizedBox(
                        height: widget.screenHeight - 140,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10.0),
                                height: 80.0,
                                child: Image.asset(
                                  "assets/images/no-internet.png",
                                  color: Colors.white.withOpacity(.3),
                                ),
                              ),
                              Text(
                                "Problème de connexion",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(.3),
                                  fontFamily: regularFont,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  return SizedBox(
                    height: widget.screenHeight - 140,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: primaryBackground,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
