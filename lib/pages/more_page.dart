import 'package:flutter/material.dart';
import 'package:loridriverflutterapp/bloc/contact_partner_bloc.dart';
import 'package:loridriverflutterapp/bloc/logout_bloc.dart';
import 'package:loridriverflutterapp/bloc/static_contents.dart';
import 'package:loridriverflutterapp/helpers/sharedpreferences.dart';
import 'package:loridriverflutterapp/models/contact_partner_model.dart';
import 'package:loridriverflutterapp/pages/about_us_page.dart';
import 'package:loridriverflutterapp/pages/contact_page.dart';
import 'package:loridriverflutterapp/pages/faqs_page.dart';
import 'package:loridriverflutterapp/pages/login_page.dart';
import 'package:loridriverflutterapp/pages/terms_and_policies_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../helpers/api_helper.dart';
import '../helpers/text_styles.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  LogOutBloc bloc = LogOutBloc();
  ContactPartnerBloc contactPartnerBloc = ContactPartnerBloc();
  ContactPartnerModel? contactPartnerModel;
  @override
  void initState() {
    logOut();
    getDriverName();
    getContactDetails();
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

  getContactDetails() async {
    await contactPartnerBloc.getPartnerData();
    contactPartnerBloc.contactsPartnerStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          // TODO: Handle this case.
          break;
        case Status.COMPLETED:
          contactPartnerModel = event.data;
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
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(contactPartnerModel?.partner?.phone);
    return Scaffold(
      //  backgroundColor: Theme.of(context).primaryColor,
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
                Text(
                  "Hey ${driverName} ,",
                  style: TextStyles().minititle(fontSize: 17, context: context),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          // listTile("assets/images/package.png", "Package Guidelines"),
          // listTile("assets/images/Terms.png", "Terms and Policies", onTap: () {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => TermsAndPoliciesPage()));
          // }),
          // listTile("assets/images/faqs.png", "FAQs", onTap: () {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => FaqsPage()));
          // }),
          // listTile("assets/images/about.png", "About", onTap: () {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => AboutUsPage()));
          // }),
          Container(
            height: 1,
            child: Divider(
              color: Theme.of(context).primaryColor ?? Colors.white,
              thickness: 0.5,
            ),
          ),
          listTile("assets/images/ic_action_contact.png", "Contact",
              context: context,
              color: Theme.of(context).primaryColor, onTap: () async {
            await UrlLauncher.launchUrl(
                Uri.parse("tel:${contactPartnerModel?.partner?.phone ?? ""}"));
          }),
          listTile("assets/images/logout.png", "Logout",
              context: context,
              color: Theme.of(context).primaryColor, onTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Dialog(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          // height: 160,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
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
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "CANCEL",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      print("object");
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();

                                      bloc.logOut(
                                          userToken:
                                              preferences.getString("token"));
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    },
                                    child: Text(
                                      "YES",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
          })
        ],
      ),
    );
  }
}

listTile(image, title, {double? height, onTap, Color? color, context}) {
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
                color: color ?? Colors.white,
                height: height ?? 25,
              ),
              title: Text(
                title,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Avenir Next LT Pro Regular",
                    fontWeight: FontWeight.w400,
                    color: color ?? Colors.white),
              ),
              textColor: Colors.white,
            ),
          ),
        ),
      ),
      Container(
        height: 1,
        child: Divider(
          color: Theme.of(context).primaryColor ?? Colors.white,
          thickness: 0.5,
        ),
      )
    ],
  );
}
