import 'dart:io';
import 'package:loridriverflutterapp/bloc/delivered_bloc.dart';
import 'package:loridriverflutterapp/bloc/orders_bloc.dart';
import 'package:loridriverflutterapp/bloc/picked_bloc.dart';
import 'package:loridriverflutterapp/widgets/snackbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:loridriverflutterapp/helpers/text_styles.dart';
import 'package:loridriverflutterapp/models/orders_model.dart';
import 'package:loridriverflutterapp/pages/map_page.dart';
import 'package:loridriverflutterapp/widgets/button_widget.dart';
import 'package:file_picker/file_picker.dart';
import '../helpers/api_helper.dart';
import '../helpers/colors.dart';
import '../widgets/bottom_bar_widget.dart';

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
  getImages({List<File>? images}) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);

    if (result != null) {
      for (var elemnt in result.paths) {
        images?.add(File(elemnt!));
        setState(() {});
      }
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future makeCall({number}) async {
    await launchUrl(Uri.parse(number));
  }

  // getOrdersData() {
  //   orderssBloc.getOrdersData();
  //   orderssBloc.orderssStream.listen((event) {
  //     switch (event.status) {
  //       case Status.LOADING:
  //       //  isLoading = true;
  //         setState(() {});
  //         break;
  //       case Status.COMPLETED:
  //      //   isLoading = false;
  //         ordersModel = event.data;
  //         setState(() {});
  //         break;
  //       case Status.ERROR:
  //         // TODO: Handle this case.
  //         break;
  //     }
  //   });
  // }

  pickedUp() {
    _bloc.pickedUpStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainBottomNavBar()));
          setState(() {});

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Successfully pickedup" ?? "")));
          break;
        case Status.ERROR:
          break;
      }
    });
  }

  delivered() {
    deliveredBloc.deliveredStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainBottomNavBar()));
          setState(() {});

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Successfully delivered" ?? "")));
          break;
        case Status.ERROR:
          showSnackBar(context: context, text: event.message ?? "");
          break;
      }
    });
  }

  @override
  void initState() {
    pickedUp();
    delivered();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            height: 550,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Visibility(
                    visible: widget.ordersData?.statusId != 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 166,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "PickUp Address",
                                        style: TextStyles().subTitle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        widget.ordersData?.pickupBuilding ?? "",
                                        style: TextStyles().subTitle(
                                            fontSize: 15,
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        widget.ordersData?.pickupApartment ??
                                            "",
                                        style: TextStyles().subTitle(
                                            fontSize: 15,
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                      Text(
                                        widget.ordersData?.pickupPhone ?? "",
                                        style: TextStyles().subTitle(
                                            fontSize: 15,
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                      Text(
                                        widget.ordersData?.pickupCity ?? "",
                                        style: TextStyles().subTitle(
                                            fontSize: 15,
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5)),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    height: 82.9,
                                    width: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MapPage(
                                                          iniLatitude: widget
                                                              .ordersData
                                                              ?.pickupLatitude,
                                                          iniLongitude: widget
                                                              .ordersData
                                                              ?.pickupLongitude,
                                                        )));
                                          },
                                          child: Image.asset(
                                            "assets/images/location.png",
                                            height: 25,
                                          ),
                                        ),
                                        Text(
                                          "Location",
                                          style: TextStyles().subTitle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await makeCall(
                                          number:
                                              widget.ordersData?.pickupPhone);
                                    },
                                    child: Container(
                                      height: 82.9,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(5)),
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
                                            style: TextStyles().subTitle(
                                                color: Colors.white,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: AppColors.greyExtraLight,
                              border:
                                  Border.all(color: Colors.black, width: 0.05)),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "PickUp Attachment",
                          style: TextStyles().subTitle(
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
                                  getImages(images: pickUpImages);
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
                                                    pickUpImages[i],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          pickUpImages
                                                              .removeAt(i);
                                                          setState(() {});
                                                        },
                                                        child: Icon(
                                                          Icons.close,
                                                          color:
                                                              Theme.of(context)
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
                        Visibility(
                          visible: widget.ordersData?.payType == 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Amount",
                                style: TextStyles().subTitle(
                                  fontSize: 15,
                                ),
                              ),

                              Text(widget.ordersData?.amount ?? ""),
                              // Container(
                              //   height: 40,
                              //   child: TextField(
                              //     controller: pickUpAmountController,
                              //     keyboardType: TextInputType.number,
                              //     decoration: InputDecoration(
                              //         contentPadding: EdgeInsets.all(0)),
                              //   ),
                              // ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                        widget.ordersData?.pickedAttachmentsModel?.isNotEmpty ??
                            false,
                    child: Container(
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PickUp Attachment",
                            style: TextStyles().subTitle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget
                                    .ordersData?.pickedAttachmentsModel?.length,
                                itemBuilder: (context, i) {
                                  return Row(
                                    children: [
                                      Container(
                                          height: 83,
                                          width: 100,
                                          child: Container(
                                            height: 83,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(widget
                                                            .ordersData
                                                            ?.pickedAttachmentsModel?[
                                                                i]
                                                            .pickedAttachment ??
                                                        ""),
                                                    fit: BoxFit.fill)),
                                          )),
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
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Delivery Address",
                                  style: TextStyles().subTitle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.ordersData?.deliveryBuilding ?? "",
                                  style: TextStyles().subTitle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.ordersData?.deliveryCity ?? "",
                                  style: TextStyles().subTitle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                Text(
                                  "${widget.ordersData?.deliveryAddress ?? ""}",
                                  style: TextStyles().subTitle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                Text(
                                  "Dubai",
                                  style: TextStyles().subTitle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.6)),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MapPage(
                                                iniLatitude: widget.ordersData
                                                    ?.deliveryLatitude,
                                                iniLongitude: widget.ordersData
                                                    ?.deliveryLongitude,
                                              )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5)),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  height: 82.9,
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/location.png",
                                        height: 25,
                                      ),
                                      Text(
                                        "Location",
                                        style: TextStyles().subTitle(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await makeCall(
                                      number: widget.ordersData?.deliveryPhone);
                                },
                                child: Container(
                                  height: 82.9,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(5)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Contact",
                                        style: TextStyles().subTitle(
                                            color: Colors.white, fontSize: 12),
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
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: AppColors.greyExtraLight,
                        border: Border.all(color: Colors.black, width: 0.05)),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Delivery Attachment",
                    style: TextStyles().subTitle(
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
                            getImages(images: deliveryImages);
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
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    deliveryImages.removeAt(i);
                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Theme.of(context)
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
                  Visibility(
                    visible: widget.ordersData?.payType == 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Amount",
                          style: TextStyles().subTitle(
                            fontSize: 15,
                          ),
                        ),
                        Text(widget.ordersData?.amount ?? ""),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Package Details",
                              style: TextStyles().subTitle(
                                fontSize: 15,
                              ),
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
                                  widget.ordersData?.packageCategory ?? "",
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
                                  widget.ordersData?.vehicleCategory ?? "",
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
                        padding: EdgeInsets.only(right: 25, bottom: 35),
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
                  Container(
                    height: 1,
                    child: Divider(
                      thickness: 0.1,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ButtonWidget(
            onTap: () {
              if (widget.ordersData?.typeId == 1) {
                pickUpImages.isNotEmpty && deliveryImages.isNotEmpty

                    //  &&
                    // (pickUpAmountController.text.isNotEmpty ||
                    //     deliveryAmountController.text.isNotEmpty)
                    ? _bloc.pickedUp(
                          amount: widget.ordersData?.amount ?? "",
                          images: pickUpImages,
                          packageId: widget.ordersData?.id,
                        ) &&
                        deliveredBloc.delivered(
                          packageId: widget.ordersData?.id,
                          images: deliveryImages,
                          amount: widget.ordersData?.amount ?? "",
                        )
                    : widget.ordersData?.statusId == 2
                        ? _bloc.pickedUp(
                            amount: widget.ordersData?.amount ?? "",
                            images: pickUpImages,
                            packageId: widget.ordersData?.id,
                          )
                        : widget.ordersData?.statusId == 3
                            ? deliveredBloc.delivered(
                                packageId: widget.ordersData?.id,
                                images: deliveryImages,
                                amount: widget.ordersData?.amount ?? "",
                              )
                            : () {};
              }
              if (widget.ordersData?.typeId == 2) {
                pickUpImages.isNotEmpty && deliveryImages.isNotEmpty
                    ? _bloc.shopOrdersPickedUp(
                          amount: widget.ordersData?.amount ?? "",
                          images: pickUpImages,
                          packageId: widget.ordersData?.id,
                        ) &&
                        deliveredBloc.shopOrdersdelivered(
                          packageId: widget.ordersData?.id,
                          images: deliveryImages,
                          amount: widget.ordersData?.amount ?? "",
                        )
                    : widget.ordersData?.statusId == 2
                        ? _bloc.shopOrdersPickedUp(
                            amount: widget.ordersData?.amount ?? "",
                            images: pickUpImages,
                            packageId: widget.ordersData?.id,
                          )
                        : widget.ordersData?.statusId == 3
                            ? deliveredBloc.shopOrdersdelivered(
                                packageId: widget.ordersData?.id,
                                images: deliveryImages,
                                amount: widget.ordersData?.amount ?? "",
                              )
                            : () {};
              }
            },
            label: widget.ordersData?.statusId == 2
                ? "PICKUP"
                : widget.ordersData?.statusId == 3
                    ? "DELIVER"
                    : "",
            borderRadius: 15,
            width: 300,
            height: 55,
          )
        ],
      )),
    );
  }
}
