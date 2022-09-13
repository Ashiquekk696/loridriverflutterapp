import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loridriverflutterapp/bloc/delivered_bloc.dart';
import 'package:loridriverflutterapp/bloc/orders_bloc.dart';
import 'package:loridriverflutterapp/bloc/picked_bloc.dart';
import 'package:loridriverflutterapp/widgets/snackbar_widget.dart';
import 'package:loridriverflutterapp/widgets/toast_widget.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';
import 'package:loridriverflutterapp/helpers/text_styles.dart';
import 'package:loridriverflutterapp/models/orders_model.dart';
import 'package:loridriverflutterapp/pages/map_page.dart';
import 'package:loridriverflutterapp/widgets/button_widget.dart';
import 'package:file_picker/file_picker.dart';
import '../helpers/api_helper.dart';
import '../helpers/colors.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/circular_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PickUpPage extends StatefulWidget {
  PickUpPage({Key? key, this.ordersData}) : super(key: key);
  BookingsModel? ordersData;
  @override
  State<PickUpPage> createState() => _PickUpPageState();
}

class _PickUpPageState extends State<PickUpPage> {
  PickedUpBloc _bloc = PickedUpBloc();
  OrderssBloc orderssBloc = OrderssBloc();
  DeliveredBloc deliveredBloc = DeliveredBloc();
  var pickUpAmountController = TextEditingController();
  var deliveryAmountController = TextEditingController();
  OrdersModel? ordersModel;
  List<File> pickUpImages = [];
  List<File> deliveryImages = [];
  // getImages({List<File>? images}) async {
  //   FilePickerResult? result = await FilePicker.platform
  //       .pickFiles(allowMultiple: true, type: FileType.image);

  //   if (result != null) {
  //     for (var elemnt in result.paths) {
  //       images?.add(File(elemnt!));
  //       setState(() {});
  //     }
  //   }
  // }

  final ImagePicker picker = ImagePicker();

  getCameraImage({List<File>? images}) async {
    XFile? cameraImages = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (cameraImages != null) {
      File file = File(cameraImages.path);
      images?.add(file);

      setState(() {});
    }
  }

  // Future<void> _launchInBrowser(Uri url) async {
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.externalApplication,
  //   )) {
  //     throw 'Could not launch $url';
  //   }
  // }

  // Future makeCall({number}) async {
  //   await launchUrl(Uri.parse(number));
  // }

  bool isLoading = false;
  pickedUp() async {
    await _bloc.pickedUpStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          isLoading = true;
          setState(() {});
          break;
        case Status.COMPLETED:
          isLoading = false;
          showToast(msg: "Successfully Pickedup");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainBottomNavBar()));

          setState(() {});

          break;
        case Status.ERROR:
          break;
      }
    });
  }

  delivered() async {
    await deliveredBloc.deliveredStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          isLoading = true;
          setState(() {});
          break;
        case Status.COMPLETED:
          showToast(msg: "Successfully Delivered");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainBottomNavBar()));

          setState(() {});
          break;
        case Status.ERROR:
          showSnackBar(context: context, text: event.message ?? "");
          break;
      }
    });
  }

  showToast({msg}) async {
    await toastWidget(
        bgColor: Colors.grey, textColor: Colors.white, msg: msg ?? "");
  }

  final GlobalKey containerKey1 = GlobalKey();
  final GlobalKey containerKey2 = GlobalKey();
  @override
  void initState() {
    pickedUp();
    delivered();
    setPickUpCashVisibility();
    setDeliveryCashVisibility();

    WidgetsBinding.instance.addPostFrameCallback((_) => getSizeAndPosition());
    super.initState();
  }

  bool cashPresentForDelivery = false;
  bool cashPresentForPickUp = false;
  setPickUpCashVisibility() {
    if (widget.ordersData?.payType == 2 &&
        widget.ordersData?.pickup == true &&
        widget.ordersData?.statusId != 3) {
      cashPresentForPickUp = true;

      setState(() {});
    }
  }

  setDeliveryCashVisibility() {
    if (widget.ordersData?.payType == 3 &&
        widget.ordersData?.delivery == true) {
      cashPresentForDelivery = true;
      setState(() {});
    }
  }

  getSizeAndPosition() {
    RenderBox? _cardBox1 =
        containerKey1.currentContext?.findAncestorRenderObjectOfType();
    if ((_cardBox1?.size.height ?? 0) < 100) {
      containerHeight1 = ((_cardBox1?.size.height ?? 0) / 2) + 10;
    } else {
      containerHeight1 = (_cardBox1?.size.height ?? 0) / 2;
    }

    cardHeight = _cardBox1?.size.height;
    RenderBox? _cardBox2 =
        containerKey2.currentContext?.findAncestorRenderObjectOfType();
    if ((_cardBox2?.size.height ?? 0) < 100) {
      containerHeight2 = ((_cardBox2?.size.height ?? 0) / 2) + 10;
    } else {
      containerHeight2 = (_cardBox2?.size.height ?? 0) / 2;
    }

    //  containerHeight2 = (_cardBox2?.size.height ?? 0) / 2;
    setState(() {});
  }

  var containerHeight1;
  var containerHeight2;
  bool cashSelected = false;
  double? cardHeight;
  @override
  void dispose() {
    _bloc.dispose();
    deliveredBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Visibility(
        visible: isLoading == false,
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: ButtonWidget(
            onTap: () {
              if (widget.ordersData?.statusId == 6) {
                showSnackBar(
                    context: context, text: "Admin needs to accept this order");
              }
              if (widget.ordersData?.userTypeId == 1) {
                if (widget.ordersData?.statusId != 3 &&
                    widget.ordersData?.pickup == true) {
                  if (pickUpImages.isEmpty) {
                    showToast(msg: "Please attach Image");
                  } else if (cashPresentForPickUp == true) {
                    if (cashSelected == false) {
                      showToast(msg: "Please collect the cash");
                    } else {
                      _bloc.pickedUp(
                        amount: widget.ordersData?.amount ?? "",
                        images: pickUpImages,
                        packageId: widget.ordersData?.id,
                      );
                    }
                  } else if (cashPresentForPickUp == false) {
                    _bloc.pickedUp(
                      amount: widget.ordersData?.amount ?? "",
                      images: pickUpImages,
                      packageId: widget.ordersData?.id,
                    );
                  }
                } else if (widget.ordersData?.delivery == true

                    // &&
                    //     widget.ordersData?.statusId == 3

                    ) {
                  if (deliveryImages.isEmpty) {
                    showToast(msg: "Please attach image");
                  } else if (cashPresentForDelivery == true) {
                    if (cashSelected == false) {
                      showToast(msg: "Please collect the cash");
                    } else {
                      deliveredBloc.delivered(
                        packageId: widget.ordersData?.id,
                        images: deliveryImages,
                        amount: widget.ordersData?.amount ?? "",
                      );
                    }
                  } else if (cashPresentForDelivery == false) {
                    deliveredBloc.delivered(
                      packageId: widget.ordersData?.id,
                      images: deliveryImages,
                      amount: widget.ordersData?.amount ?? "",
                    );
                  }
                }
              }
              if (widget.ordersData?.userTypeId == 2) {
                if (widget.ordersData?.statusId != 3 &&
                    widget.ordersData?.pickup == true) {
                  if (pickUpImages.isEmpty) {
                    showToast(msg: "Please attach image");
                  } else if (cashPresentForPickUp == true) {
                    if (cashSelected == false) {
                      showToast(msg: "Please collect the cash");
                    } else {
                      _bloc.shopOrdersPickedUp(
                        amount: widget.ordersData?.amount ?? "",
                        images: pickUpImages,
                        packageId: widget.ordersData?.id,
                      );
                    }
                  } else if (cashPresentForPickUp == false) {
                    _bloc.shopOrdersPickedUp(
                      amount: widget.ordersData?.amount ?? "",
                      images: pickUpImages,
                      packageId: widget.ordersData?.id,
                    );
                  }
                } else if (widget.ordersData?.delivery == true &&
                        widget.ordersData?.statusId == 3 ||
                    widget.ordersData?.delivery == true &&
                        widget?.ordersData?.pickup == false &&
                        widget.ordersData?.statusId == 2) {
                  if (deliveryImages.isEmpty) {
                    showToast(msg: "Please attach image");
                  } else if (cashPresentForDelivery == true) {
                    if (cashSelected == false) {
                      showToast(msg: "Please collect the cash");
                    } else {
                      print("object");
                      deliveredBloc.shopOrdersdelivered(
                        amount: widget.ordersData?.amount ?? "",
                        images: deliveryImages,
                        packageId: widget.ordersData?.id,
                      );
                    }
                  } else if (cashPresentForDelivery == false) {
                    deliveredBloc.shopOrdersdelivered(
                      amount: widget.ordersData?.amount ?? "",
                      images: deliveryImages,
                      packageId: widget.ordersData?.id,
                    );
                  }
                }

                // pickUpImages.isNotEmpty &&

                //     //  &&
                //     // (pickUpAmountController.text.isNotEmpty ||
                //     //     deliveryAmountController.text.isNotEmpty)
                //     ? _bloc.shopOrdersPickedUp(
                //         amount: widget.ordersData?.amount ?? "",
                //         images: pickUpImages,
                //         packageId: widget.ordersData?.id,
                //       )
                //     : deliveryImages.isNotEmpty &&
                //             widget.ordersData?.statusId == 3
                //         ? deliveredBloc.shopOrdersdelivered(
                //             packageId: widget.ordersData?.id,
                //             images: deliveryImages,
                //             amount: widget.ordersData?.amount ?? "",
                //           )
                //         : () {};
              }
            },
            label: widget.ordersData?.statusId == 6
                ? "Awaiting Payment"
                : widget.ordersData?.statusId == 2 &&
                        widget.ordersData?.pickup == true
                    ? "Pick Up"
                    : widget.ordersData?.statusId == 2 &&
                            widget.ordersData?.pickup == false
                        ? "Deliver"
                        : widget.ordersData?.statusId == 3
                            ? "Deliver"
                            : "",
            borderRadius: 15,
            width: 70,
            height: 55,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
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
                      Text("PACKAGE #${widget.ordersData?.id ?? ""}",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
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
                : Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    //height: 550,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Visibility(
                            visible: widget.ordersData?.pickup == true &&
                                widget.ordersData?.statusId != 3,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("PickUp Details",
                                    style: TextStyles()
                                        .mainAppStyle(fontSize: 15)),
                                SizedBox(
                                  height: 15,
                                ),
                                LayoutBuilder(builder: (context, constraints) {
                                  print(constraints.constrainHeight());
                                  return Container(
                                    key: containerKey1,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),

                                                // ),
                                                Visibility(
                                                  visible: widget.ordersData
                                                          ?.userPickupTime !=
                                                      "",
                                                  child: Text(
                                                    widget.ordersData
                                                            ?.userPickupTime ??
                                                        "",
                                                    style: TextStyles()
                                                        .subTitle(fontSize: 12),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Visibility(
                                                  visible: widget.ordersData
                                                          ?.pickupDate !=
                                                      "",
                                                  child: Text(
                                                    widget.ordersData
                                                            ?.pickupDate ??
                                                        "",
                                                    style:
                                                        TextStyles().subTitle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   height: 5,
                                                // ),
                                                // Visibility(
                                                //   visible: widget.ordersData
                                                //           ?.pickupAddress !=
                                                //       "",
                                                //   child: Text(
                                                //     widget.ordersData
                                                //             ?.pickupCity ??
                                                //         "",
                                                //     style:
                                                //         TextStyles().subTitle(
                                                //       fontSize: 12,
                                                //     ),
                                                //   ),
                                                // ),

                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Visibility(
                                                  visible: widget.ordersData
                                                          ?.pickupAddress !=
                                                      "",
                                                  child: Text(
                                                    "${widget.ordersData?.pickupAddress}" ??
                                                        "",
                                                    style:
                                                        TextStyles().subTitle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5)),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              height: containerHeight1,
                                              width: 100,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      // Navigator.push(
                                                      //     context,
                                                      // MaterialPageRoute(
                                                      //     builder:
                                                      //         (context) =>
                                                      //             MapPage(
                                                      //               iniLatitude: widget
                                                      //                   .ordersData
                                                      //                   ?.pickupLatitude,
                                                      //               iniLongitude: widget
                                                      //                   .ordersData
                                                      //                   ?.pickupLongitude,
                                                      //             )));
                                                      MapUtils.openMap(
                                                          double.parse(widget
                                                                  .ordersData
                                                                  ?.pickupLatitude ??
                                                              ""),
                                                          double.parse(widget
                                                                  .ordersData
                                                                  ?.pickupLongitude ??
                                                              ""));
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/location.png",
                                                      height: 25,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Location",
                                                    style: TextStyles()
                                                        .subTitle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                  )
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await UrlLauncher.launchUrl(
                                                    Uri.parse(
                                                        "tel:${widget.ordersData?.pickupPhone ?? ""}"));
                                              },
                                              child: Container(
                                                height: containerHeight1,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5)),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.phone,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Contact",
                                                      style: TextStyles()
                                                          .subTitle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    //   margin: EdgeInsets.only(left: 20, right: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: AppColors.greyExtraLight,
                                        border: Border.all(
                                            color: Colors.black, width: 0.05)),
                                  );
                                }),
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  "PickUp Attachment",
                                  style: TextStyles().mainAppStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 83,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          //getImages(images: pickUpImages);
                                          getCameraImage(images: pickUpImages);
                                          // _showPicker(context, pickUpImages);
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 83,
                                          width: 100,
                                          color: Colors.grey.withOpacity(0.1),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.black38,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: pickUpImages.length,
                                            itemBuilder: (context, i) {
                                              return Row(
                                                children: [
                                                  Container(
                                                    height: 83,
                                                    width: 100,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          height: 83,
                                                          width: 100,
                                                          child: Image.file(
                                                            // pickUpImages[i],

                                                            pickUpImages[i],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  pickUpImages
                                                                      .removeAt(
                                                                          i);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 22,
                                                                ),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  )
                                                ],
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          cashPresentForPickUp
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 21,
                                      child: Checkbox(
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          value: cashSelected,
                                          onChanged: (v) {
                                            print(v);
                                            cashSelected = !cashSelected;
                                            setState(() {});
                                          }),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Collect Cash",
                                      style: TextStyles().mainAppStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "AED ${widget.ordersData?.amount}" ?? "",
                                      style: TextStyles().mainAppStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          Visibility(
                            visible: widget.ordersData?.delivery == true,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.ordersData?.pickup == true &&
                                        widget.ordersData?.statusId != 3
                                    ? SizedBox(
                                        height: 20,
                                      )
                                    : Container(),
                                Text(
                                  "Delivery Details",
                                  style: TextStyles().mainAppStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                LayoutBuilder(builder: (context, constraints) {
                                  return Container(
                                    key: containerKey2,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  widget.ordersData
                                                          ?.userDeliveryTime ??
                                                      "",
                                                  style: TextStyles().subTitle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  widget.ordersData
                                                          ?.deliveryDate ??
                                                      "",
                                                  style: TextStyles().subTitle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   height: 5,
                                                // ),
                                                // Text(
                                                //   widget.ordersData
                                                //           ?.deliveryCity ??
                                                //       "",
                                                //   style: TextStyles().subTitle(
                                                //     fontSize: 12,
                                                //   ),
                                                // ),

                                                 SizedBox(
                                                  height: 5,
                                                ),
                                                Visibility(
                                                  visible: widget.ordersData
                                                          ?.deliveryAddress !=
                                                      "",
                                                  child: Text(
                                                    "${widget.ordersData?.deliveryAddress}" ??
                                                        "",
                                                    style:
                                                        TextStyles().subTitle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          //  color: Colors.red,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             MapPage(
                                                  //               iniLatitude: widget
                                                  //                   .ordersData
                                                  //                   ?.deliveryLatitude,
                                                  //               iniLongitude: widget
                                                  //                   .ordersData
                                                  //                   ?.deliveryLongitude,
                                                  //             )));
                                                  MapUtils.openMap(
                                                      double.parse(widget
                                                              .ordersData
                                                              ?.deliveryLatitude ??
                                                          ""),
                                                      double.parse(widget
                                                              .ordersData
                                                              ?.deliveryLongitude ??
                                                          ""));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    5)),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  height: containerHeight2,
                                                  width: 100,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/location.png",
                                                        height: 25,
                                                      ),
                                                      Text(
                                                        "Location",
                                                        style: TextStyles()
                                                            .subTitle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await UrlLauncher.launchUrl(
                                                      Uri.parse(
                                                          "tel:${widget.ordersData?.deliveryPhone ?? ""}"));
                                                },
                                                child: Container(
                                                  height: containerHeight2,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5)),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.phone,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Contact",
                                                        style: TextStyles()
                                                            .subTitle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    //   margin: EdgeInsets.only(left: 20, right: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: AppColors.greyExtraLight,
                                        border: Border.all(
                                            color: Colors.black, width: 0.05)),
                                  );
                                }),
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  "Delivery Attachment",
                                  style: TextStyles().mainAppStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 83,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          if (widget.ordersData?.statusId ==
                                                  2 &&
                                              widget.ordersData?.pickup ==
                                                  true) {
                                            await toastWidget(
                                                bgColor: Colors.grey,
                                                textColor: Colors.white,
                                                msg:
                                                    "You haven't picked the item yet");
                                            setState(() {});
                                            // showSnackBar(
                                            //     context: context,
                                            //     text: "You haven't picked yet");

                                          } else
                                            // getImages(images: deliveryImages);
                                            // _showPicker(
                                            //     context, deliveryImages);
                                            getCameraImage(
                                                images: deliveryImages);
                                        },
                                        child: Container(
                                          height: 83,
                                          width: 100,
                                          color: Colors.grey.withOpacity(0.1),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.black38,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: deliveryImages.length,
                                            itemBuilder: (context, i) {
                                              return Row(
                                                children: [
                                                  Container(
                                                    height: 83,
                                                    width: 100,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          height: 83,
                                                          width: 100,
                                                          child: Image.file(
                                                            deliveryImages[i],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  deliveryImages
                                                                      .removeAt(
                                                                          i);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 22,
                                                                ),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  )
                                                ],
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                          cashPresentForDelivery
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 21,
                                      child: Checkbox(
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          value: cashSelected,
                                          onChanged: (v) {
                                            print(v);
                                            if (widget.ordersData?.pickup ==
                                                    true &&
                                                widget.ordersData?.delivery ==
                                                    true &&
                                                widget.ordersData?.statusId ==
                                                    2) {
                                              showToast(
                                                  msg:
                                                      "Please pick up the item first");
                                            } else {
                                              cashSelected = !cashSelected;
                                            }
                                            setState(() {});
                                          }),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Collect Cash",
                                      style: TextStyles().mainAppStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "AED ${widget.ordersData?.amount}" ?? "",
                                      style: TextStyles().mainAppStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Package Details",
                                      style: TextStyles().mainAppStyle(
                                          fontSize: double.parse("15"),
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Item Name: ",
                                          style: TextStyles().subTitle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          widget.ordersData?.packageName ?? "",
                                          style: TextStyles().subTitle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Package Type: ",
                                          style: TextStyles().subTitle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          widget.ordersData?.packageCategory ??
                                              "",
                                          style: TextStyles().subTitle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Delivery Vehicle: ",
                                          style: TextStyles().subTitle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          widget.ordersData?.vehicleCategory ??
                                              "",
                                          style: TextStyles().subTitle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Instructions: ",
                                          style: TextStyles().subTitle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          widget.ordersData?.instructions ?? "",
                                          style: TextStyles().subTitle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 35),
                                child: Image.asset(
                                  "assets/images/package.png",
                                  height: 60,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // Container(
                          //   height: 1,
                          //   child: Divider(
                          //     thickness: 0.1,
                          //     color: Colors.black,
                          //   ),
                          // ),
                          Visibility(
                            visible: widget.ordersData?.payType == 2 ||
                                widget.ordersData?.payType == 3,
                            child: Container(
                              //height: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Cash Details",
                                    style: TextStyles().mainAppStyle(
                                        fontSize: double.parse("15"),
                                        color: Colors.black),
                                  ),
                                  // RichText(
                                  //   text: TextSpan(
                                  //       text: "Cash",
                                  //       style: TextStyles().styleBolded(
                                  //           fontSize: double.parse("20"),
                                  //           color: Colors.black),
                                  //       children: [
                                  //         TextSpan(
                                  //             text: " Details",
                                  //             style: TextStyles().subTitle(
                                  //                 fontSize: double.parse("20"),
                                  //                 color: Colors.black))
                                  //       ]),
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Item Cost",
                                        style: TextStyles().subTitle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),

                                      // RichText(
                                      //   text: TextSpan(
                                      //       text: "Item",
                                      //       style: TextStyles().subTitle(
                                      //           fontSize: double.parse("18"),
                                      //           color: Colors.black),
                                      //       children: [
                                      //         TextSpan(
                                      //             text: " Cost",
                                      //             style: TextStyles()
                                      //                 .styleBolded(
                                      //                     fontSize:
                                      //                         double.parse(
                                      //                             "18"),
                                      //                     color: Colors.black))
                                      //       ]),
                                      // ),
                                      Spacer(),
                                      Text(
                                        "AED ${widget.ordersData?.amount}" ??
                                            "",
                                        style: TextStyles().mainAppStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // Divider(
                                  //   color: Colors.grey,
                                  //   thickness: 0.3,
                                  // ),
                                  Row(
                                    children: [
                                      Text(
                                        "Delivery Cost",
                                        style: TextStyles().subTitle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Text(
                                        "AED ${widget.ordersData?.actualAmount}" ??
                                            "",
                                        style: TextStyles().mainAppStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
    );
  }
}
