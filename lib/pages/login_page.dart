import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loridriverflutterapp/bloc/login_bloc.dart';
import 'package:loridriverflutterapp/pages/forgot_password_page.dart';
import 'package:loridriverflutterapp/services/login_services.dart';
import 'package:loridriverflutterapp/widgets/bottom_bar_widget.dart';
import 'package:loridriverflutterapp/widgets/button_widget.dart';
import 'package:loridriverflutterapp/widgets/textfield_widget.dart';

import '../helpers/api_helper.dart';
import '../widgets/toast_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var userNameError;
  LoginBloc _bloc = LoginBloc();
  @override
  void initState() {
    login();
    super.initState();
  }

  login() {
    _bloc.loginStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          showToast(msg: "Login Successfull");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainBottomNavBar()));

          setState(() {});
          break;
        case Status.ERROR:
          break;
      }
    });
  }

  showToast({msg}) async {
    await toastWidget(
        bgColor: Colors.grey, textColor: Colors.white, msg: msg ?? "");
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 211,
              ),
              Image.asset(
                "assets/images/headerlogo.png",
                height: 38,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Driver App",
                  style: TextStyle(
                      fontSize: 21,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 0)),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.only(left: 64, right: 64),
                child: TextFieldWidget(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username or email required";
                    }
                    if (value.isNotEmpty) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (emailValid == false) {
                        return "Invalid email";
                      }
                      setState(() {});
                    }
                  },
                  image: "assets/images/user.png",
                  label: "Username or email",
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.only(left: 64, right: 64),
                child: TextFieldWidget(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password required";
                    }
                  },
                  controller: _passwordController,
                  image: "assets/images/password.png",
                  label: "Password",
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()));
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              ButtonWidget(
                onTap: () {
                  _formKey.currentState?.validate();
                  _bloc.login(
                      email: emailController.text,
                      password: _passwordController.text);
                },
                label: "LOGIN",
                labelColor: Colors.black,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Container error({errorText}) {
  return Container(
    height: 15,
    color: Colors.black,
    child: Text(
      errorText,
      style: TextStyle(color: Colors.white),
    ),
  );
}
