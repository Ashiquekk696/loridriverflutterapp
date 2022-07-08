import 'package:flutter/material.dart';
import 'package:loridriverflutterapp/bloc/faq_bloc.dart';
import 'package:loridriverflutterapp/models/faq_model.dart';

import '../helpers/api_helper.dart';
import '../widgets/static_content_listtile_widget.dart';

class FaqsPage extends StatefulWidget {
  const FaqsPage({Key? key}) : super(key: key);

  @override
  State<FaqsPage> createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  FaqBloc _bloc = FaqBloc();
  FaqModel? faqModel;

  bool isLoading = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    _bloc.getFaqData();
    _bloc.faqStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          isLoading = true;
          setState(() {});
          break;
        case Status.COMPLETED:
          isLoading = false;
          faqModel = event.data;
          setState(() {});
          break;
        case Status.ERROR:
          // TODO: Handle this case.
          break;
      }
    });
  }

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
                      Text("FAQs",
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
                  Text("Frequently Asked Questions",
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
            ExpansionTile(
              onExpansionChanged: (v) {},
              leading: Image.asset(
                "assets/images/faqs.png",
                color: Color(0xFF751e78),
                height: 25,
              ),
              //minLeadingWidth: 20,
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.grey.withOpacity(0.2),
              ),
              title: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  "General FAQ",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              textColor: Colors.white,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Text(faqModel?.faq?[0].description ?? ""),
                )
              ],
            ),
            ExpansionTile(
              onExpansionChanged: (v) {},
              leading: Image.asset(
                "assets/images/faqs.png",
                color: Color(0xFF751e78),
                height: 25,
              ),
              //minLeadingWidth: 20,
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.grey.withOpacity(0.2),
              ),
              title: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  "Payment FAQ",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              textColor: Colors.white,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Text(faqModel?.faq?[1].description ?? ""),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
