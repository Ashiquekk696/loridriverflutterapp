import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loridriverflutterapp/bloc/cash_collected_bloc.dart';
import 'package:loridriverflutterapp/helpers/colors.dart';
import 'package:loridriverflutterapp/models/cash_collected_model.dart';
import 'package:loridriverflutterapp/models/cash_submitted_model.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../bloc/submitted_cash_bloc.dart';
import '../helpers/api_helper.dart';
import '../helpers/text_styles.dart';
import '../widgets/circular_indicator.dart';
import '../widgets/custom_toggle_widget.dart';

class CashPage extends StatefulWidget {
  const CashPage({Key? key}) : super(key: key);

  @override
  State<CashPage> createState() => _CashPageState();
}

class _CashPageState extends State<CashPage> {
  CollectedCashBloc collectedCashBlocBloc = CollectedCashBloc();
  SubmittedCashBloc submittedCashBloc = SubmittedCashBloc();
  CashSubmittedModel? submittedModel;
  CashCollectedModel? collectedCashModel;
  bool isLoading = false;
  var toggleValue;
  var sel = false;
  getCollectedCashData() {
    collectedCashBlocBloc.getCollectedCashData();
    collectedCashBlocBloc.cashCollectedStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          isLoading = true;
          setState(() {});
          break;
        case Status.COMPLETED:
          isLoading = false;
          collectedCashModel = event.data;
          setState(() {});
          break;
        case Status.ERROR:
          // TODO: Handle this case.
          break;
      }
    });
  }

  getSubmittedCashData() {
    submittedCashBloc.getSubmittedCashData();
    submittedCashBloc.submittedCashStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          isLoading = true;
          setState(() {});
          break;
        case Status.COMPLETED:
          isLoading = false;
          submittedModel = event.data;
          setState(() {});
          break;
        case Status.ERROR:
          // TODO: Handle this case.
          break;
      }
    });
  }

  @override
  void initState() {
    getCollectedCashData();
    getSubmittedCashData();
    super.initState();
  }

  @override
  void dispose() {
    submittedCashBloc.dispose();
    collectedCashBlocBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Theme.of(context).primaryColor, //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(left: 15, right: 15),
      child: isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 220,
                ),
                CircularIndicator(),
              ],
            )
          : Column(
              children: [
                Container(
                  height: 98,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Text("CASH",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
                CustomToggleWidget(
                  firstLabel: "Cash Submitted",
                  secondLabel: "Cash in Hand",
                  onTogle: (v) {
                    toggleSelectedValue = v;
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: toggleSelectedValue == 0,
                  child: Flexible(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Cash Submitted:",
                                style: TextStyles().subTitle(fontSize: 14),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "AED ${submittedModel?.total.toString() ?? ""}",
                                style: TextStyles().subTitle(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                            child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                              //    physics: NeverScrollableScrollPhysics(),
                              itemCount: submittedModel?.cashSubmitted?.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      // height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: AppColors.greyExtraLight,
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 0.05)),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // SizedBox(
                                                //   width: 1,
                                                // ),

                                                RichText(
                                                    text: TextSpan(
                                                        text: "Package",
                                                        style: TextStyles()
                                                            .minititle(
                                                                fontSize: 16,
                                                                context:
                                                                    context),
                                                        children: [
                                                      TextSpan(
                                                        text:
                                                            "#${submittedModel?.cashSubmitted?[index].bookingId.toString()}",
                                                        style: TextStyles()
                                                            .minititle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black,
                                                                context:
                                                                    context),
                                                      )
                                                    ])),
                                                //
                                                Text(
                                                    "AED ${submittedModel?.cashSubmitted?[index].cash.toString() ?? ""}",
                                                    style: TextStyles()
                                                        .subTitle(
                                                            fontSize: 15)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                );
                              }),
                        )),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: toggleSelectedValue == 1,
                  child: Flexible(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Cash in Hand:",
                                style: TextStyles().subTitle(fontSize: 14),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "AED ${collectedCashModel?.total.toString() ?? ""}",
                                style: TextStyles().subTitle(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    collectedCashModel?.cashCollected?.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: AppColors.greyExtraLight,
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 0.05)),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // SizedBox(
                                                  //   width: 1,
                                                  // ),

                                                  RichText(
                                                      text: TextSpan(
                                                          text: "Package",
                                                          style: TextStyles()
                                                              .minititle(
                                                                  fontSize: 16,
                                                                  context:
                                                                      context),
                                                          children: [
                                                        TextSpan(
                                                          text:
                                                              "#${collectedCashModel?.cashCollected?[index].bookingId.toString()}",
                                                          style: TextStyles()
                                                              .minititle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  context:
                                                                      context),
                                                        )
                                                      ])),

                                                  Text(
                                                      "AED ${collectedCashModel?.cashCollected?[index].cash.toString() ?? ""}",
                                                      style: TextStyles()
                                                          .subTitle(
                                                              fontSize: 15)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    ));
  }
}
