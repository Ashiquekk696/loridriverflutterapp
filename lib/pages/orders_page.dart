import 'package:flutter/material.dart';
import 'package:loridriverflutterapp/bloc/orders_bloc.dart';
import 'package:loridriverflutterapp/helpers/text_styles.dart';
import 'package:loridriverflutterapp/models/orders_model.dart';
import 'package:loridriverflutterapp/pages/pickup_page.dart';
import 'package:loridriverflutterapp/widgets/appbar_widget.dart';
import 'package:loridriverflutterapp/widgets/button_widget.dart';

import '../helpers/api_helper.dart';
import '../helpers/colors.dart';
import '../widgets/circular_indicator.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  OrderssBloc _bloc = OrderssBloc();
  OrdersModel? ordersModel;

  bool isLoading = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    _bloc.getOrdersData();
    _bloc.orderssStream.listen((event) {
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
    //print(ordersModel?.bookings?[0].deliveryName);
    return Scaffold(
      appBar: LoriAppBar(),
      body: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              isLoading
                  ? Column(
                      children: [
                        SizedBox(
                          height: 190,
                        ),
                        CircularIndicator(),
                      ],
                    )
                  : ordersModel?.bookings == null ||
                          (ordersModel?.bookings ?? []).isEmpty ||
                          ordersModel?.bookings?.length == 0
                      ? Column(
                          children: [
                            SizedBox(
                              height: 255,
                            ),
                            Text("No orders found")
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
                                                  Expanded(
                                                    child: Text(
                                                      "#${ordersModel?.bookings?[index].id.toString() ?? ""}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontFamily:
                                                              "Source Sans Pro",
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: ordersModel
                                                            ?.bookings?[index]
                                                            .pickup !=
                                                        false,
                                                    child: ordersModel
                                                                        ?.bookings?[
                                                                            index]
                                                                        .statusId ==
                                                                    3 &&
                                                                ordersModel
                                                                        ?.bookings?[
                                                                            index]
                                                                        .delivery ==
                                                                    false ||
                                                            ordersModel
                                                                    ?.bookings?[
                                                                        index]
                                                                    .statusId ==
                                                                4
                                                        ? Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .green),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.done,
                                                                color: Colors
                                                                    .white,
                                                                size: 25,
                                                              ),
                                                            ),
                                                          )
                                                        : ButtonWidget(
                                                            fontSize: 13,
                                                            onTap: () {
                                                              print(
                                                                  "amount is ${ordersModel?.bookings?[index].amount}");
                                                              ordersModel?.bookings?[index].statusId ==
                                                                          2 ||
                                                                      ordersModel
                                                                              ?.bookings?[index]
                                                                              .statusId ==
                                                                          3
                                                                  ? Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => PickUpPage(
                                                                                ordersData: ordersModel?.bookings?[index],
                                                                              )))
                                                                  : null;
                                                            },
                                                            label: ordersModel
                                                                        ?.bookings?[
                                                                            index]
                                                                        .statusId ==
                                                                    2
                                                                ? "Pick Up"
                                                                : ordersModel
                                                                            ?.bookings?[
                                                                                index]
                                                                            .statusId ==
                                                                        3
                                                                    ? "Deliver"
                                                                    : ordersModel
                                                                            ?.bookings?[index]
                                                                            .status ??
                                                                        "",
                                                            height: 40,
                                                            width: 100,
                                                            borderRadius: 5,
                                                          ),
                                                  )
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
                                                        color:
                                                            Color(0xFF757575),
                                                        fontSize: 14,
                                                        //    fontFamily: "Source Sans Pro",
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    "  ${ordersModel?.bookings?[index].pickupCity}" ??
                                                        "",
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
                                                        color:
                                                            Color(0xFF757575),
                                                        fontSize: 14,
                                                        //    fontFamily: "Source Sans Pro",
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    "  ${ordersModel?.bookings?[index].deliveryCity}" ??
                                                        "",
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
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.more_time,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 27,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 140),
                                                    child: Text(
                                                      "${ordersModel?.bookings?[index].userPickupTime}",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14,
                                                          //    fontFamily: "Source Sans Pro",
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.calendar_month,
                                                      color: Colors.grey,
                                                    ),
                                                    SizedBox(
                                                      width: 28,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${ordersModel?.bookings?[index].pickupDate}",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14,
                                                            //    fontFamily: "Source Sans Pro",
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    Text(
                                                        "AED ${ordersModel?.bookings?[index].amount}",
                                                        style: TextStyles()
                                                            .styleBolded(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor)),
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
                                    ],
                                  );
                                }),
                          ),
                        )
            ],
          )
          //  Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text(
          //       "No orders found",
          //     ),
          //   ],
          // ),

          ),
    );
  }
}
