import 'package:flutter/material.dart';
import 'package:loridriverflutterapp/bloc/orders_bloc.dart';
import 'package:loridriverflutterapp/helpers/text_styles.dart';
import 'package:loridriverflutterapp/models/orders_model.dart';
import 'package:loridriverflutterapp/pages/login_page.dart';
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
          isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
          setState(() {});
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
                            Text("No orders for today")
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
                                      GestureDetector(
                                        onTap: () {
                                          // ordersModel?.bookings?[index]
                                          //                     .statusId !=
                                          //                 3 &&
                                          //             ordersModel
                                          //                     ?.bookings?[index]
                                          //                     .delivery !=
                                          //                 false ||
                                          //         ordersModel?.bookings?[index]
                                          //                     .statusId !=
                                          //                 4 &&
                                          //             (ordersModel
                                          //                         ?.bookings?[
                                          //                             index]
                                          //                         .statusId ==
                                          //                     2 ||
                                          //                 ordersModel
                                          //                         ?.bookings?[
                                          //                             index]
                                          //                         .statusId ==
                                          //                     3)
                                          ordersModel?.bookings?[index]
                                                          .statusId ==
                                                      4 ||
                                                  (ordersModel?.bookings?[index]
                                                              .statusId ==
                                                          3 &&
                                                      ordersModel
                                                              ?.bookings?[index]
                                                              .delivery ==
                                                          false)
                                              ? null
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PickUpPage(
                                                            ordersData: ordersModel
                                                                    ?.bookings?[
                                                                index],
                                                          )));
                                        },
                                        child: Container(
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
                                                  height: 20,
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
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                          "#${ordersModel?.bookings?[index].id.toString() ?? ""}",
                                                          style: TextStyles()
                                                              .minititle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  context:
                                                                      context)),
                                                    ),
                                                    ordersModel
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
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: AppColors
                                                                    .lightGreen),
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
                                                            fontSize: 11,
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
                                                                        2 &&
                                                                    ordersModel
                                                                            ?.bookings?[
                                                                                index]
                                                                            .pickup ==
                                                                        true
                                                                ? "Pick Up"
                                                                : ordersModel?.bookings?[index].statusId == 2 &&
                                                                        ordersModel?.bookings?[index].pickup ==
                                                                            false &&
                                                                        ordersModel?.bookings?[index].delivery ==
                                                                            true
                                                                    ? "Deliver"
                                                                    : ordersModel?.bookings?[index].statusId ==
                                                                            3
                                                                        ? "Deliver"
                                                                        : ordersModel?.bookings?[index].status ??
                                                                            "",
                                                            height: 30,
                                                            width: 100,
                                                            borderRadius: 5,
                                                          )
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
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xFF757575)),
                                                    ),
                                                    Text(
                                                      "  ${ordersModel?.bookings?[index].pickupCity}" ??
                                                          "",
                                                      style: TextStyles()
                                                          .mainAppStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
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
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xFF757575)),
                                                    ),
                                                    Text(
                                                      "  ${ordersModel?.bookings?[index].deliveryCity}" ??
                                                          "",
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
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.more_time,
                                                      color: Color(0xFF757575),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      ordersModel
                                                                      ?.bookings?[
                                                                          index]
                                                                      .pickup ==
                                                                  true &&
                                                              ordersModel
                                                                      ?.bookings?[
                                                                          index]
                                                                      .delivery ==
                                                                  false
                                                          //      &&
                                                          // ordersModel
                                                          //         ?.bookings?[
                                                          //             index]
                                                          //         .statusId !=
                                                          //     3 &&
                                                          // ordersModel
                                                          //         ?.bookings?[
                                                          //             index]
                                                          //         .delivery ==
                                                          //     false
                                                          ? "${ordersModel?.bookings?[index].userPickupTime}"
                                                          : ordersModel
                                                                          ?.bookings?[
                                                                              index]
                                                                          .pickup ==
                                                                      true &&
                                                                  ordersModel
                                                                          ?.bookings?[
                                                                              index]
                                                                          .delivery ==
                                                                      true
                                                              ? "${ordersModel?.bookings?[index].userDeliveryTime}"
                                                              : ordersModel?.bookings?[index].delivery ==
                                                                          true &&
                                                                      ordersModel
                                                                              ?.bookings?[index]
                                                                              .pickup ==
                                                                          false
                                                                  ? "${ordersModel?.bookings?[index].userDeliveryTime}"
                                                                  : "",
                                                      style: TextStyles()
                                                          .mainAppStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 11,
                                                              color: Color(
                                                                  0xFF757575)),
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
                                                        color:
                                                            Color(0xFF757575),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          ordersModel
                                                                          ?.bookings?[
                                                                              index]
                                                                          .pickup ==
                                                                      true &&
                                                                  ordersModel
                                                                          ?.bookings?[
                                                                              index]
                                                                          .delivery ==
                                                                      false
                                                              //      &&
                                                              // ordersModel
                                                              //         ?.bookings?[
                                                              //             index]
                                                              //         .statusId !=
                                                              //     3 &&
                                                              // ordersModel
                                                              //         ?.bookings?[
                                                              //             index]
                                                              //         .delivery ==
                                                              //     false
                                                              ? "${ordersModel?.bookings?[index].pickupDate}"
                                                              : ordersModel?.bookings?[index].pickup ==
                                                                          true &&
                                                                      ordersModel
                                                                              ?.bookings?[
                                                                                  index]
                                                                              .delivery ==
                                                                          true
                                                                  ? "${ordersModel?.bookings?[index].deliveryDate}"
                                                                  : ordersModel?.bookings?[index].delivery ==
                                                                              true &&
                                                                          ordersModel?.bookings?[index].pickup ==
                                                                              false
                                                                      ? "${ordersModel?.bookings?[index].deliveryDate}"
                                                                      : "",
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
