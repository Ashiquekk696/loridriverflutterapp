import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:loridriverflutterapp/bloc/static_contents.dart';

import '../helpers/api_helper.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  void initState() {
    getStaticData();
    super.initState();
  }

  var data = "";
  StaticContentsBloc staticContentsBloc = StaticContentsBloc();
  getStaticData() {
    staticContentsBloc.privacyPolicyData(type: 'about_us');
    staticContentsBloc.staticContentsStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          data = event.data ?? "";
          setState(() {});
          break;
        case Status.ERROR:
          break;
      }
    });
  }

  @override
  void dispose() {
    staticContentsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 55,
          ),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: HtmlWidget(data))
        ],
      ),
    );
  }
}
