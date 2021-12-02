// ignore_for_file: deprecated_member_use, unused_field

import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'package:todoapp/common/common.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/screens/main_layout.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  late Animation iconAnimation,
      textAnimation,
      formAnimation,
      bottomTextAnimation;

  late AnimationController animationController;
  bool islogin = true;
  bool isPasswordObscure = true;
  bool isLoadingAuth = false;
  bool isLoadingSave = false;

  String error = "";
  bool showError = false;

  String? _title = "";
  String? _category = "business";
  DateTime? _date = DateTime.now();
  // String formatDate(DateTime date) => DateFormat("MMMM d").format(date);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dueTimeController = TextEditingController();
  // final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _isDoneController = TextEditingController();
  final List<String> _categoryController = ["business", "personal"];
  // ignore: unnecessary_new
  final _dateFormater = 'MMM dd yyyy';

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: _date!,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dueTimeController.text = _dateFormater;
    }
  }

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    iconAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    textAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.4, 1.0, curve: Curves.fastOutSlowIn)));

    formAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn)));

    bottomTextAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.6, 1.0, curve: Curves.elasticInOut)));

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          backgroundColor: primaryBackground,
          body: Center(
            child: ListView(
              children: [
                Transform(
                  transform: Matrix4.translationValues(
                      0.0, iconAnimation.value * screenHeight, 0.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child: Text(
                          "TODO APP",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.3),
                            fontFamily: 'bebas',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        height: 80.0,
                        child: Image.asset(
                          "assets/images/todo_app_logo.png",
                          color: Colors.white.withOpacity(.3),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: islogin
                      ? Column(
                          children: [
                            Transform(
                              transform: Matrix4.translationValues(
                                  0.0, textAnimation.value * screenHeight, 0.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 60.0,
                                  ),
                                  Icon(
                                    Icons.task_alt_outlined,
                                    size: 50.0,
                                    color: secondBackground,
                                  ),
                                  Center(
                                    child: Text(
                                      "Creer un nouveau task",
                                      style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: secondBackground,
                                        fontSize: 20.0,
                                        fontFamily: 'bebas',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  0.0, textAnimation.value * screenHeight, 0.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 20.0,
                                  ),
                                  Center(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 20.0,
                                            right: 50.0,
                                            left: 50.0,
                                          ),
                                          decoration: inputDecoration(),
                                          child: IconTheme(
                                            data: IconThemeData(
                                              color:
                                                  Colors.white.withOpacity(.3),
                                            ),
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 9.0,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextField(
                                                      cursorColor:
                                                          secondBackground,
                                                      controller:
                                                          _titleController,
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                                  hintText:
                                                                      "Title",
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    color:
                                                                        secondBackground,
                                                                  )),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "LiberationSerif",
                                                        color: Colors.white,
                                                      ),
                                                      obscureText: false,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40.0,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 20.0,
                                            right: 50.0,
                                            left: 50.0,
                                          ),
                                          decoration: inputDecoration(),
                                          child: IconTheme(
                                            data: IconThemeData(
                                              color:
                                                  Colors.white.withOpacity(.3),
                                            ),
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 9.0,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextField(
                                                      readOnly: true,
                                                      controller:
                                                          _dueTimeController,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "LiberationSerif",
                                                          color: Colors.white,
                                                          fontSize: 18),
                                                      onTap: _handleDatePicker,
                                                      cursorColor:
                                                          secondBackground,
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                                  hintText:
                                                                      "Date",
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    color:
                                                                        secondBackground,
                                                                  )),
                                                      obscureText: false,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40.0,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 20.0,
                                            right: 50.0,
                                            left: 50.0,
                                          ),
                                          decoration: inputDecoration(),
                                          child: DropdownButtonFormField(
                                            isDense: true,
                                            icon: Icon(
                                                Icons.arrow_drop_down_circle),
                                            iconSize: 22.0,
                                            iconEnabledColor:
                                                Theme.of(context).primaryColor,
                                            style: TextStyle(fontSize: 18),
                                            decoration: InputDecoration(
                                                labelText: 'category',
                                                labelStyle: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'ProximaNova',
                                                  color: secondBackground,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0))),
                                            validator: (dynamic input) =>
                                                input.toString().trim().isEmpty
                                                    ? 'Svp selectionner un task'
                                                    : null,
                                            items: _categoryController
                                                .map((String priority) {
                                              return DropdownMenuItem(
                                                  value: priority,
                                                  child: new Text(
                                                    priority,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'ProximaNova',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 18.0),
                                                  ));
                                            }).toList(),
                                            onChanged: (dynamic newValue) {
                                              print(newValue.runtimeType);
                                              setState(() {
                                                _category = newValue.toString();
                                              });
                                            },
                                            // value : _priority
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: showError
                                        ? Text(
                                            error,
                                            style: TextStyle(
                                              fontFamily: "LiberationSerif",
                                              color: Colors.red,
                                            ),
                                          )
                                        : null,
                                  ),
                                  Container(
                                    height: 40.0,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                      right: 50.0,
                                      left: 50.0,
                                    ),
                                    decoration: BoxDecoration(
                                        color:
                                            (_titleController.text.isNotEmpty)
                                                ? Colors.teal
                                                : Colors.grey,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(14.0),
                                        )),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor: Colors.tealAccent,
                                        child: Center(
                                            child: isLoadingAuth
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Text(
                                                    "Enregistrer",
                                                    style: TextStyle(
                                                      fontFamily: "bebas",
                                                      letterSpacing: 1.0,
                                                      color: Colors.white
                                                          .withOpacity(.8),
                                                      fontSize: 20.0,
                                                    ),
                                                  )),
                                        onTap: () async {
                                          if (_titleController
                                                  .text.isNotEmpty &&
                                              _dueTimeController
                                                  .text.isNotEmpty) {
                                            Task task = Task(
                                                title: _titleController.text,
                                                dueTime: DateTime.now(),
                                                category:
                                                    _categoryController[0],
                                                isDone: true);
                                            setState(() {
                                              isLoadingAuth = true;
                                            });
                                            var response = await http.post(
                                                tasksListURL,
                                                headers: {
                                                  HttpHeaders.contentTypeHeader:
                                                      'application/json'
                                                },
                                                body: convert
                                                    .jsonEncode(task.toJson()));
                                            setState(() {
                                              isLoadingAuth = false;
                                            });

                                            if (response.body == "true") {
                                              _titleController.clear();
                                              _dueTimeController.clear();
                                              _isDoneController.clear();
                                              _categoryController.clear();
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MainLayout(),
                                              ));
                                            } else {
                                              error = "les m!";
                                              setState(() {
                                                showError = true;
                                              });
                                              await Future.delayed(
                                                  Duration(seconds: 5), () {
                                                setState(() {
                                                  error = "";
                                                  showError = false;
                                                });
                                              });
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainLayout()));
                                          },
                                          color: secondBackground,
                                          child: Column(
                                            children: [
                                              Icon(Icons.arrow_back_ios_new),
                                              Text("Retour a la page d'accueil")
                                            ],
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(),
                ),
                SizedBox(
                  height: screenHeight - (islogin ? 600.0 : 600.0),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      0.0, bottomTextAnimation.value * screenHeight, 0.0),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "Design by Alex",
                        style: TextStyle(
                          color: Colors.white.withOpacity(.3),
                          fontFamily: 'bebas',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
