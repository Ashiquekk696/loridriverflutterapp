import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loridriverflutterapp/bloc/notifications_bloc.dart';
import 'package:loridriverflutterapp/helpers/colors.dart';
import 'package:loridriverflutterapp/models/notifications_model.dart';
import 'package:loridriverflutterapp/models/orders_model.dart';
import 'package:loridriverflutterapp/widgets/circular_indicator.dart';

import '../helpers/api_helper.dart';
import '../helpers/text_styles.dart';

// class NotificationsPage extends StatefulWidget {
//   const NotificationsPage({Key? key}) : super(key: key);

//   @override
//   State<NotificationsPage> createState() => _NotificationsPageState();
// }

// class _NotificationsPageState extends State<NotificationsPage> {
//   bool isLoading = false;
//   NotificationsBloc _bloc = NotificationsBloc();
//   NotificationsModel? notificationsModel;
//   @override
//   void initState() {
//     getNotifications();
//     super.initState();
//   }

//   getNotifications() async {
//     await _bloc.getNotificationsData();
//     await _bloc.notificationsStream.listen((event) {
//       switch (event.status) {
//         case Status.LOADING:
//           isLoading = true;
//           setState(() {});
//           break;
//         case Status.COMPLETED:
//           isLoading = false;
//         //  print("my datsa is ${event.data?.pastData[0]}");
//           notificationsModel = event.data;
//           setState(() {});
//           break;
//         case Status.ERROR:
//           // TODO: Handle this case.
//           break;
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _bloc.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //print(notificationsModel?.pastData[0]?.bookings?[0].id);
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor:
//           Theme.of(context).primaryColor, //or set color with: Color(0xFF0000FF)
//     ));

//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.only(left: 15, right: 15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 22,
//             ),
//             Container(
//               // height: 60,
//               width: double.infinity,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 25,
//                   ),
//                   Text("NOTIFICATION",
//                       style: Theme.of(context).textTheme.titleMedium),
//                   SizedBox(
//                     height: 12,
//                   ),
//                 ],
//               ),
//             ),
//             isLoading
//                 ? Column(
//                     children: [
//                       SizedBox(
//                         height: 190,
//                       ),
//                       CircularIndicator(),
//                     ],
//                   )
//                 : notificationsModel?.past?.length == 0
//                     ? Column(
//                         children: [
//                           SizedBox(
//                             height: 255,
//                           ),
//                           Text("No notifications found")
//                         ],
//                       )
//                     : Expanded(
//                         child: MediaQuery.removePadding(
//                           context: context,
//                           removeTop: true,
//                           child: ListView.builder(
//                               itemCount: notificationsModel?.past?.length,
//                               itemBuilder: (context, index) {
//                                 return Column(
//                                   children: [
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(5)),
//                                           color: AppColors.greyExtraLight,
//                                           border: Border.all(
//                                               color: Colors.black,
//                                               width: 0.05)),
//                                       child: Container(
//                                         margin: EdgeInsets.only(
//                                             left: 15, right: 15),
//                                         child: Column(
//                                           children: [
//                                             SizedBox(
//                                               height: 15,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   "Package",
//                                                   style: TextStyle(
//                                                       color: Theme.of(context)
//                                                           .primaryColor,
//                                                       fontSize: 18,
//                                                       fontFamily:
//                                                           "Source Sans Pro",
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 ),
//                                                 SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 Text(
//                                                   "#${notificationsModel?.past?[index].id.toString()}" ??
//                                                       "",
//                                                   style: TextStyle(
//                                                       color: Colors.black,
//                                                       fontSize: 18,
//                                                       fontFamily:
//                                                           "Source Sans Pro",
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: 18,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   "Pickup :",
//                                                   style: TextStyle(
//                                                       color: Color(0xFF757575),
//                                                       fontSize: 14,
//                                                       //    fontFamily: "Source Sans Pro",
//                                                       fontWeight:
//                                                           FontWeight.w400),
//                                                 ),
//                                                 Text(
//                                                   "  ${notificationsModel?.past?[index].pickupCity.toString()}",
//                                                   style: TextStyle(
//                                                       color: Colors.black,
//                                                       fontSize: 14,
//                                                       //    fontFamily: "Source Sans Pro",
//                                                       fontWeight:
//                                                           FontWeight.w400),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: 5,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   "Delivery :",
//                                                   style: TextStyle(
//                                                       color: Color(0xFF757575),
//                                                       fontSize: 14,
//                                                       //    fontFamily: "Source Sans Pro",
//                                                       fontWeight:
//                                                           FontWeight.w400),
//                                                 ),
//                                                 Text(
//                                                   "  ${notificationsModel?.past?[index].deliveryCity.toString()}",
//                                                   style: TextStyle(
//                                                       color: Colors.black,
//                                                       fontSize: 14,
//                                                       //    fontFamily: "Source Sans Pro",
//                                                       fontWeight:
//                                                           FontWeight.w400),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: 5,
//                                             ),
//                                             Container(
//                                               margin:
//                                                   EdgeInsets.only(right: 15),
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.calendar_month,
//                                                     color: Colors.grey,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 5,
//                                                   ),
//                                                   Expanded(
//                                                     child: Text(
//                                                       "${notificationsModel?.past?[index].pickupDate.toString()}",
//                                                       style: TextStyle(
//                                                           color: Colors.grey,
//                                                           fontSize: 14,
//                                                           //    fontFamily: "Source Sans Pro",
//                                                           fontWeight:
//                                                               FontWeight.w400),
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     " AED ${notificationsModel?.past?[index].amount.toString()}",
//                                                     style: TextStyles()
//                                                         .styleBolded(
//                                                       color: Theme.of(context)
//                                                           .primaryColor,
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 15,
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                   ],
//                                 );
//                               }),
//                         ),
//                       )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loridriverflutterapp/bloc/cash_collected_bloc.dart';
import 'package:loridriverflutterapp/helpers/colors.dart';
import 'package:loridriverflutterapp/models/cash_collected_model.dart';
import 'package:loridriverflutterapp/models/cash_submitted_model.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../bloc/submitted_cash_bloc.dart';
import '../helpers/api_helper.dart';
import '../widgets/circular_indicator.dart';
import '../widgets/custom_toggle_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationsBloc bloc = NotificationsBloc();
  NotificationsModel? model;
  bool isLoading = true;
  var toggleValue;
  var sel = false;

  getNotifications() async {
    await bloc.getNotificationsData();
    await bloc.notificationsStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          isLoading = true;
          setState(() {});
          break;
        case Status.COMPLETED:
          isLoading = false;
          //  print("my datsa is ${event.data?.pastData[0]}");
          model = event.data;
          setState(() {});
          break;
        case Status.ERROR:
          isLoading = false;
          setState(() {});
          break;
      }
    });
  }

  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();

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
                      Text("NOTIFICATIONS",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
                CustomToggleWidget(
                  firstLabel: "Upcoming",
                  secondLabel: "Past",
                  onTogle: (v) {
                    toggleSelectedValue = v;
                    setState(() {});
                  },
                ),
                Visibility(
                  visible: toggleSelectedValue == 0,
                  child: Flexible(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Expanded(
                          child: MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView.builder(
                                itemCount: model?.upcoming?.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: AppColors.greyExtraLight,
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 0.05)),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Package",
                                                    style: TextStyles()
                                                        .minititle(
                                                            context: context),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "#${model?.upcoming?[index].id.toString()}" ??
                                                        "",
                                                    style: TextStyles()
                                                        .minititle(
                                                            context: context,
                                                            color: Colors.black,
                                                            fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Pickup :",
                                                    style: TextStyles()
                                                        .mainAppStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                                0xFF757575)),
                                                  ),
                                                  Text(
                                                    "  ${model?.upcoming?[index].pickupCity.toString()}",
                                                    style: TextStyles()
                                                        .mainAppStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Delivery :",
                                                    style: TextStyles()
                                                        .mainAppStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                                0xFF757575)),
                                                  ),
                                                  Text(
                                                    "  ${model?.upcoming?[index].deliveryCity.toString()}",
                                                    style: TextStyles()
                                                        .mainAppStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 15),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.calendar_month,
                                                      color: Colors.grey,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${model?.upcoming?[index].pickupDate.toString()}",
                                                        style: TextStyles()
                                                            .mainAppStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xFF757575)),
                                                      ),
                                                    ),
                                                    Text(
                                                      " AED ${model?.upcoming?[index].amount.toString()}",
                                                      style: TextStyles()
                                                          .styleBolded(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              )
                                            ],
                                          ),
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
                Visibility(
                  visible: toggleSelectedValue == 1,
                  child: Flexible(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Expanded(
                            child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                              itemCount: model?.past?.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: AppColors.greyExtraLight,
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 0.05)),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                Text("Package",
                                                    style: TextStyles()
                                                        .minititle(
                                                            context: context)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    "#${model?.past?[index].id.toString()}" ??
                                                        "",
                                                    style: TextStyles()
                                                        .minititle(
                                                            context: context,
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Pickup :",
                                                  style: TextStyles()
                                                      .mainAppStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                          color: Color(
                                                              0xFF757575)),
                                                ),
                                                Text(
                                                  "  ${model?.past?[index].pickupCity.toString()}",
                                                  style:
                                                      TextStyles().mainAppStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Delivery :",
                                                  style: TextStyles()
                                                      .mainAppStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xFF757575)),
                                                ),
                                                Text(
                                                  "  ${model?.past?[index].deliveryCity.toString()}",
                                                  style: TextStyles()
                                                      .mainAppStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${model?.past?[index].pickupDate.toString()}",
                                                      style: TextStyles()
                                                          .mainAppStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 11,
                                                              color: Color(
                                                                  0xFF757575)),
                                                    ),
                                                  ),
                                                  Text(
                                                    " AED ${model?.past?[index].amount.toString()}",
                                                    style: TextStyles()
                                                        .styleBolded(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        ),
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
              ],
            ),
    ));
  }
}
