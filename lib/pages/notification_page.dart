import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loridriverflutterapp/bloc/notifications_bloc.dart';
import 'package:loridriverflutterapp/helpers/colors.dart';
import 'package:loridriverflutterapp/models/orders_model.dart';
import 'package:loridriverflutterapp/widgets/circular_indicator.dart';

import '../helpers/api_helper.dart';
import '../helpers/text_styles.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool isLoading = false;
  NotificationsBloc _bloc = NotificationsBloc();
  OrdersModel? ordersModel;
  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  getNotifications() {
    _bloc.getNotificationsData();
    _bloc.notificationsStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          isLoading = true;
          setState(() {});
          break;
        case Status.COMPLETED:
          isLoading = false;
          ordersModel = event.data;
          setState(() {});
          break;
        case Status.ERROR:
          // TODO: Handle this case.
          break;
      }
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(ordersModel?.bookings?[0].id);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Theme.of(context).primaryColor, //or set color with: Color(0xFF0000FF)
    ));

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 22,
            ),
            Container(
              height: 60,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 18,
                  // ),
                  Text("NOTIFICATION",
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
            isLoading
                ? Column(
                    children: [
                      SizedBox(
                        height: 190,
                      ),
                      CircularIndicator(),
                    ],
                  )
                : ordersModel?.bookings?.length == 0
                    ? Column(
                        children: [
                          SizedBox(
                            height: 255,
                          ),
                          Text("No notifications found")
                        ],
                      )
                    : Expanded(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                              itemCount: ordersModel?.bookings?.length,
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
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 18,
                                                      fontFamily:
                                                          "Source Sans Pro",
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "#${ordersModel?.bookings?[index].id.toString()}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontFamily:
                                                          "Source Sans Pro",
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 18,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Pickup :",
                                                  style: TextStyle(
                                                      color: Color(0xFF757575),
                                                      fontSize: 14,
                                                      //    fontFamily: "Source Sans Pro",
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  "  ${ordersModel?.bookings?[index].pickupCity.toString()}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      //    fontFamily: "Source Sans Pro",
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                                  style: TextStyle(
                                                      color: Color(0xFF757575),
                                                      fontSize: 14,
                                                      //    fontFamily: "Source Sans Pro",
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  "  ${ordersModel?.bookings?[index].deliveryCity.toString()}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      //    fontFamily: "Source Sans Pro",
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                                      "${ordersModel?.bookings?[index].pickupDate.toString()}",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14,
                                                          //    fontFamily: "Source Sans Pro",
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Text(
                                                    " AED ${ordersModel?.bookings?[index].amount.toString()}",
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
                      )
          ],
        ),
      ),
    );
  }
}
