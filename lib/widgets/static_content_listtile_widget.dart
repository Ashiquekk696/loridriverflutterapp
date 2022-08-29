import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../bloc/static_contents.dart';
import '../helpers/api_helper.dart';

class ListTileWidget extends StatefulWidget {
  ListTileWidget({Key? key, this.image, this.title, this.type})
      : super(key: key);
  var image;
  var title;
  double? height;
  var type;
  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  var data = "";
  StaticContentsBloc staticContentsBloc = StaticContentsBloc();
  getStaticData() {
    staticContentsBloc.privacyPolicyData(type: widget.type);
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
  void initState() {
    getStaticData();

    super.initState();
  }

  @override
  void dispose() {
    staticContentsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          ExpansionTile(
            onExpansionChanged: (v) {},
            leading: Image.asset(
              widget.image,
              color: Color(0xFF751e78),
              height: widget.height ?? 25,
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
                widget.title,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Open Sans",
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            textColor: Colors.white,
            children: [HtmlWidget(data ?? "")],
          ),
          Container(
            height: 1,
            child: Divider(
              thickness: 0.1,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
