import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../bloc/static_contents.dart';
import '../helpers/api_helper.dart';
import '../widgets/static_content_listtile_widget.dart';

class TermsAndPoliciesPage extends StatefulWidget {
  const TermsAndPoliciesPage({Key? key}) : super(key: key);

  @override
  State<TermsAndPoliciesPage> createState() => _TermsAndPoliciesPageState();
}

class _TermsAndPoliciesPageState extends State<TermsAndPoliciesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        ),
                      ),
                      Text("TERMS AND POLICIES",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text("Terms and Policies",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTileWidget(
              image: "assets/images/comment.png",
              title: "Privacy Policy",
              type: "privacy_policy",
            ),
            ListTileWidget(
              image: "assets/images/comment.png",
              title: "Terms and Policies",
              type: "terms_conditions",
            ),
            ListTileWidget(
              image: "assets/images/comment.png",
              title: "Return and Refund Policy",
              type: "return_policy",
            ),
            ListTileWidget(
              image: "assets/images/comment.png",
              title: "Payback Policy",
              type: "buyback_policy",
            ),
            ListTileWidget(
              image: "assets/images/comment.png",
              title: "Exchange Policy",
              type: "exchange_policy",
            ),
            ListTileWidget(
              image: "assets/images/comment.png",
              title: "Terms and Policies",
              type: "shipping_policy",
            )
          ],
        ),
      ),
    );
  }
}
