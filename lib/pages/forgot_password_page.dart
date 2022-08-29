import 'package:flutter/material.dart';
import 'package:loridriverflutterapp/bloc/forgot_password_bloc.dart';
import 'package:loridriverflutterapp/pages/login_page.dart';
import 'package:loridriverflutterapp/widgets/button_widget.dart';
import 'package:loridriverflutterapp/widgets/textfield_widget.dart';

import '../helpers/api_helper.dart';
import '../widgets/toast_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  ForgotPasswordBloc _bloc = ForgotPasswordBloc();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    forgotPassword();
    super.initState();
  }

  forgotPassword() {
    _bloc.forgotPasswordStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          showToast(msg: "Successfull");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 115,
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
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 72,
                ),
                Text("Forgot Password?",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0)),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(left: 64, right: 64),
              child: TextFieldWidget(
                controller: emailController,
                image: "assets/images/password.png",
                label: "Username or email",
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 25,
            ),
            ButtonWidget(
              onTap: () {
                _bloc.forgptPassword(email: emailController.text);
              },
              label: "Send",
              labelColor: Colors.black,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
