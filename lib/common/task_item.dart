// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/common/common.dart';
import 'package:todoapp/models/category.dart';
import 'package:todoapp/models/task.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: primaryBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.all(2),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: widget.task.category == "business"
                    ? businessIndicator
                    : personalIndicator,
                shape: BoxShape.circle,
              ),
              child: widget.task.isDone
                  ? Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: primaryBackground,
                        shape: BoxShape.circle,
                      ),
                    ),
            ),
          ),
          Text(
            " " + widget.task.title + " ",
            style: TextStyle(
              decoration: widget.task.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              fontFamily: regularFont,
              color: Colors.white.withOpacity(.8),
            ),
          ),
        ],
      ),
    );
  }
}
