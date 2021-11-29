import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todoapp/common/common.dart';
import 'package:todoapp/models/user.dart';
import 'package:todoapp/screens/main_layout.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
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

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameNewController = TextEditingController();
  final TextEditingController _passwordNewController = TextEditingController();
  final TextEditingController _repeatPwdController = TextEditingController();

  // var authenticationtURL = Uri.https(backendDN, '/authenticate');

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
                                    Icons.person,
                                    size: 50.0,
                                    color: secondBackground,
                                  ),
                                  Center(
                                    child: Text(
                                      "Connectez-vous",
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
                                                          _usernameController,
                                                      decoration: InputDecoration
                                                          .collapsed(
                                                              hintText:
                                                                  "Username",
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
                                            bottom: 20.0,
                                            right: 50.0,
                                            left: 40.0,
                                          ),
                                          child: IconTheme(
                                            data: IconThemeData(
                                              color: secondBackground,
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
                                                    controller:
                                                        _passwordController,
                                                    cursorColor:
                                                        secondBackground,
                                                    decoration: InputDecoration
                                                        .collapsed(
                                                      hintText: "Password",
                                                      hintStyle: TextStyle(
                                                        color: secondBackground,
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "LiberationSerif",
                                                      color: Colors.white,
                                                    ),
                                                    obscureText:
                                                        isPasswordObscure,
                                                  )),
                                                  InkWell(
                                                    child: SizedBox(
                                                      child: Icon(
                                                        isPasswordObscure
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off,
                                                        color: secondBackground,
                                                      ),
                                                      height: 40.0,
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        isPasswordObscure =
                                                            !isPasswordObscure;
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
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
                                        color: (_usernameController
                                                .text.isNotEmpty)
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
                                                    "S'authentifier",
                                                    style: TextStyle(
                                                      fontFamily: "bebas",
                                                      letterSpacing: 1.0,
                                                      color: Colors.white
                                                          .withOpacity(.8),
                                                      fontSize: 20.0,
                                                    ),
                                                  )),
                                        onTap: () async {
                                          if (_usernameController
                                                  .text.isNotEmpty &&
                                              _passwordController
                                                  .text.isNotEmpty) {
                                            User user = User(
                                                userName:
                                                    _usernameController.text,
                                                password:
                                                    _passwordController.text);
                                            setState(() {
                                              isLoadingAuth = true;
                                            });
                                            var response = await http.post(
                                                authenticationtURL,
                                                headers: {
                                                  HttpHeaders.contentTypeHeader:
                                                      'application/json'
                                                },
                                                body: convert
                                                    .jsonEncode(user.toJson()));
                                            setState(() {
                                              isLoadingAuth = false;
                                            });
                                            //:ignore_type_equility_checks
                                            if (response.body == "true") {
                                              _usernameController.clear();
                                              _passwordController.clear();
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MainLayout(),
                                              ));
                                            } else {
                                              error =
                                                  "Usename ou mot de passe incorrect!";
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
                                      Text(
                                        "Pas de compte",
                                        style: TextStyle(
                                          color: secondBackground,
                                        ),
                                      ),
                                      InkWell(
                                        child: Text(
                                          "Creez en un.",
                                          style: TextStyle(
                                              color: Colors.white,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            islogin = false;
                                          });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(children: [
                          Transform(
                            transform: Matrix4.translationValues(
                                0.0, textAnimation.value * screenHeight, 0.0),
                            child: Column(children: <Widget>[
                              SizedBox(
                                height: 60.0,
                              ),
                              Icon(
                                Icons.app_registration,
                                size: 50.0,
                                color: secondBackground,
                              ),
                              Center(
                                child: Text("Creez votre compte",
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: secondBackground,
                                    )),
                              ),
                            ]),
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                0.0, formAnimation.value * screenHeight, 0.0),
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
                                                          _usernameNewController,
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                        hintText: "Username",
                                                        hintStyle: TextStyle(
                                                          color:
                                                              secondBackground,
                                                        ),
                                                      ),
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
                                                  ),
                                                ],
                                              ),
                                            )),
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
                                            color: secondBackground,
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 9.0,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: TextField(
                                                    cursorColor:
                                                        secondBackground,
                                                    controller:
                                                        _passwordNewController,
                                                    decoration: InputDecoration
                                                        .collapsed(
                                                      hintText: "Password ",
                                                      hintStyle: TextStyle(
                                                        color: secondBackground,
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "LiberationSerif",
                                                      color: Colors.white,
                                                    ),
                                                    obscureText:
                                                        isPasswordObscure,
                                                  ),
                                                ),
                                                InkWell(
                                                  child: SizedBox(
                                                    child: Icon(
                                                      isPasswordObscure
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: secondBackground,
                                                    ),
                                                    height: 40.0,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      if (isPasswordObscure) {
                                                        isPasswordObscure =
                                                            false;
                                                      } else {
                                                        isPasswordObscure =
                                                            true;
                                                      }
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 20.0,
                                          bottom: 20.0,
                                          right: 50.0,
                                          left: 50.0,
                                        ),
                                        decoration: inputDecoration(),
                                        child: IconTheme(
                                          data: IconThemeData(
                                            color: secondBackground,
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 9.0,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: TextField(
                                                    controller:
                                                        _repeatPwdController,
                                                    cursorColor:
                                                        secondBackground,
                                                    decoration: InputDecoration
                                                        .collapsed(
                                                      hintText:
                                                          "Repeat Password ",
                                                      hintStyle: TextStyle(
                                                        color: secondBackground,
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "LiberationSerif",
                                                      color: Colors.white,
                                                    ),
                                                    obscureText:
                                                        isPasswordObscure,
                                                  ),
                                                ),
                                                InkWell(
                                                  child: SizedBox(
                                                    child: Icon(
                                                      isPasswordObscure
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: secondBackground,
                                                    ),
                                                    height: 40.0,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      if (isPasswordObscure) {
                                                        isPasswordObscure =
                                                            false;
                                                      } else {
                                                        isPasswordObscure =
                                                            true;
                                                      }
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
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
                                        (_usernameNewController
                                                    .text.isNotEmpty &&
                                                _passwordNewController
                                                    .text.isNotEmpty &&
                                                _repeatPwdController
                                                    .text.isNotEmpty)
                                            ? Colors.teal
                                            : Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(14.0),
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      splashColor: Colors.tealAccent,
                                      child: Center(
                                        child: isLoadingSave
                                            ? CircularProgressIndicator()
                                            : Text(
                                                "Valider",
                                                style: TextStyle(
                                                  fontFamily: "bebas",
                                                  letterSpacing: 1.0,
                                                  color: Colors.white
                                                      .withOpacity(.8),
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                      ),
                                      onTap: () async {
                                        if (_usernameNewController.text.isNotEmpty &&
                                            _passwordNewController
                                                .text.isNotEmpty &&
                                            _repeatPwdController
                                                .text.isNotEmpty) {
                                          if (_repeatPwdController.text !=
                                              _passwordNewController.text) {
                                            error =
                                                "Les mots de passe sont different.";
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
                                          } else {
                                            User user = User(
                                                userName:
                                                    _usernameNewController.text,
                                                password: _passwordNewController
                                                    .text);
                                            setState(() {
                                              isLoadingSave = true;
                                            });
                                            var response = await http.post(
                                                authenticationtURL,
                                                headers: {
                                                  "content-type":
                                                      "application/json"
                                                },
                                                body: user.toJson());
                                            setState(() {
                                              isLoadingSave = true;
                                            });

                                            if (response.statusCode == 201) {
                                              _usernameNewController.clear();
                                              _passwordNewController.clear();
                                              _repeatPwdController.clear();
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          MainLayout(),
                                                ),
                                              );
                                            } else {
                                              error =
                                                  "un probleme est survenu, veuillez réessayer!";
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
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Vous avez un compte ?   ",
                                      style: TextStyle(
                                        color: secondBackground,
                                      ),
                                    ),
                                    InkWell(
                                      child: Text(
                                        "Connectez-vous.",
                                        style: TextStyle(
                                            color: Colors.white,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          islogin = true;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ]),
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
