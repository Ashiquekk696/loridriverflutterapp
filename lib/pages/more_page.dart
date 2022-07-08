import 'package:flutter/material.dart';
import 'package:loridriverflutterapp/bloc/logout_bloc.dart';
import 'package:loridriverflutterapp/bloc/static_contents.dart';
import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
import 'package:loridriverflutterapp/pages/about_us_page.dart';
import 'package:loridriverflutterapp/pages/contact_page.dart';
import 'package:loridriverflutterapp/pages/faqs_page.dart';
import 'package:loridriverflutterapp/pages/login_page.dart';
import 'package:loridriverflutterapp/pages/terms_and_policies_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/api_helper.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  LogOutBloc bloc = LogOutBloc();

  @override
  void initState() {
    logOut();
    getDriverName();
    super.initState();
  }

  logOut() {
    bloc.logOutStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          // TODO: Handle this case.
          break;
        case Status.COMPLETED:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
          setState(() {});
          break;
        case Status.ERROR:
          // TODO: Handle this case.
          break;
      }
    });
  }

  var driverName;
  getDriverName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    driverName = preferences.getString("driverName");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Container(
            height: 85,
            color: Colors.white,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text("MORE", style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Text("Hey ${driverName} ,",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Open Sans",
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          listTile("assets/images/package.png", "Package Guidelines"),
          listTile("assets/images/comment.png", "Terms and Policies",
              onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TermsAndPoliciesPage()));
          }),
          listTile("assets/images/faqs.png", "FAQs", height: 30, onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FaqsPage()));
          }),
          listTile("assets/images/about.png", "About", height: 28, onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AboutUsPage()));
          }),
          listTile("assets/images/ic_action_contact.png", "Contact", height: 20,
              onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactPage()));
          }),
          listTile("assets/images/logout.png", "Logout", onTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return Dialog(
                    child: Container(
                      height: 160,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Do you want to logout?",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 140,
                              ),
                              Text(
                                "CANCEL",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  print("object");
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();

                                  bloc.logOut(
                                      userToken:
                                          preferences.getString("token"));
                                },
                                child: Text(
                                  "YES",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          })
        ],
      ),
    );
  }
}

listTile(image, title, {double? height, onTap}) {
  return Column(
    children: [
      SizedBox(
        height: 5,
      ),
      Padding(
        padding: EdgeInsets.only(left: 10),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            //  color: Colors.red,
            child: ListTile(
              minLeadingWidth: 30,
              leading: Image.asset(
                image,
                color: Colors.white,
                height: height ?? 25,
              ),
              title: Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Open Sans",
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              textColor: Colors.white,
            ),
          ),
        ),
      ),
      Container(
        height: 1,
        child: Divider(
          color: Colors.white,
          thickness: 0.5,
        ),
      )
    ],
  );
}
