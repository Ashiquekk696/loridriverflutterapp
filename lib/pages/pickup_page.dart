import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:loridriverflutterapp/bloc/delivered_bloc.dart';
import 'package:loridriverflutterapp/bloc/orders_bloc.dart';
import 'package:loridriverflutterapp/bloc/picked_bloc.dart';
import 'package:loridriverflutterapp/widgets/snackbar_widget.dart';
import 'package:loridriverflutterapp/widgets/toast_widget.dart';
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

  // List<File> image = [];

  _imgFromGallery({List<File>? images}) async {
    List<XFile>? pickedImages = await picker.pickMultiImage();

    if (pickedImages != null) {
      for (var element in pickedImages) {
        File file = File(element.path);
        images?.add(file);

        setState(() {});
      }
    }
  }

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

  void _showPicker(context, List<File>? images) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(images: images);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      getCameraImage(images: images);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
    WidgetsBinding.instance.addPostFrameCallback((_) => getSizeAndPosition());
    super.initState();
  }

  getSizeAndPosition() {
    RenderBox? _cardBox1 =
        containerKey1.currentContext?.findAncestorRenderObjectOfType();
    containerHeight1 = (_cardBox1?.size.height ?? 0) / 2;
    cardHeight = _cardBox1?.size.height;
    RenderBox? _cardBox2 =
        containerKey2.currentContext?.findAncestorRenderObjectOfType();
    containerHeight2 = (_cardBox2?.size.height ?? 0) / 2;
    setState(() {});
  }

  var containerHeight1;
  var containerHeight2;
  double? cardHeight;
  @override
  void dispose() {
    _bloc.dispose();
    deliveredBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("hhh${widget.ordersData?.deliveryName}");
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
                  height: 550,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Visibility(
                          visible: widget.ordersData?.pickup == true,
                          child: Visibility(
                            visible: widget.ordersData?.statusId != 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LayoutBuilder(builder: (context, constraints) {
                                  print(constraints.constrainHeight());
                                  return Container(
                                    key: containerKey1,
                                    // height: ((cardHeight ?? 0) < 160)
                                    //     ? 190
                                    //     : cardHeight,
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

                                                (widget.ordersData
                                                                ?.pickUpName ??
                                                            "") !=
                                                        ""
                                                    ? Text(
                                                        widget.ordersData
                                                                ?.pickUpName ??
                                                            "",
                                                        style: TextStyles()
                                                            .subTitle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.6)))
                                                    : Container(),

                                                (widget.ordersData?.pickupAddressNo ??
                                                                "") !=
                                                            "" ||
                                                        (widget.ordersData
                                                                    ?.pickUpAddressName ??
                                                                "") !=
                                                            ""
                                                    ? Text(
                                                        (widget.ordersData
                                                                        ?.pickupAddressType ??
                                                                    "") ==
                                                                "Apartment"
                                                            ? (widget.ordersData
                                                                    ?.pickupAddressNo ??
                                                                "")
                                                            : (widget.ordersData
                                                                            ?.pickupAddressType ??
                                                                        "") ==
                                                                    "Villa"
                                                                ? (widget
                                                                        .ordersData
                                                                        ?.pickUpAddressName ??
                                                                    "")
                                                                : (widget.ordersData?.pickupAddressType ??
                                                                            "") ==
                                                                        "Building"
                                                                    ? (widget
                                                                            .ordersData
                                                                            ?.pickUpAddressName ??
                                                                        "")
                                                                    : "",
                                                        style: TextStyles()
                                                            .subTitle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.6)),
                                                      )
                                                    : Container(),
                                                // SizedBox(
                                                //   height: 10,
                                                // ),
                                                (widget.ordersData?.pickUpAddressFloor ??
                                                                "") !=
                                                            "" ||
                                                        (widget.ordersData
                                                                    ?.pickupAddressStreet ??
                                                                "") !=
                                                            ""
                                                    ? Text(
                                                        (widget.ordersData
                                                                        ?.pickupAddressType ??
                                                                    "") ==
                                                                "Apartment"
                                                            ? (widget.ordersData
                                                                    ?.pickUpAddressFloor ??
                                                                "")
                                                            : (widget.ordersData
                                                                            ?.pickupAddressType ??
                                                                        "") ==
                                                                    "Villa"
                                                                ? (widget
                                                                        .ordersData
                                                                        ?.pickupAddressStreet ??
                                                                    "")
                                                                : (widget.ordersData?.pickupAddressType ??
                                                                            "") ==
                                                                        "Building"
                                                                    ? (widget
                                                                            .ordersData
                                                                            ?.pickUpAddressFloor ??
                                                                        "")
                                                                    : "",
                                                        style: TextStyles()
                                                            .subTitle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.6)),
                                                      )
                                                    : Container(),

                                                Visibility(
                                                  visible: widget.ordersData
                                                              ?.pickupAddressType !=
                                                          "Villa" &&
                                                      (widget.ordersData
                                                                  ?.pickUpAddressBuilding !=
                                                              "" ||
                                                          widget.ordersData
                                                                  ?.pickupAddressStreet !=
                                                              ""),
                                                  child: Text(
                                                    widget.ordersData
                                                                ?.pickupAddressType ==
                                                            "Apartment"
                                                        ? (widget.ordersData
                                                                ?.pickUpAddressBuilding ??
                                                            "")
                                                        : (widget.ordersData
                                                                        ?.pickupAddressType ??
                                                                    "") ==
                                                                "Building"
                                                            ? (widget.ordersData
                                                                    ?.pickupAddressStreet ??
                                                                "")
                                                            : "",
                                                    style: TextStyles()
                                                        .subTitle(
                                                            fontSize: 15,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.6)),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: widget
                                                              .ordersData?.pickupAddressType !=
                                                          "Villa" &&
                                                      widget.ordersData
                                                              ?.pickupAddressType !=
                                                          "Building" &&
                                                      (widget.ordersData
                                                                  ?.pickupAddressStreet ??
                                                              "") !=
                                                          "",
                                                  child: Text(
                                                    (widget.ordersData
                                                            ?.pickupAddressStreet ??
                                                        ""),
                                                    style: TextStyles()
                                                        .subTitle(
                                                            fontSize: 15,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.6)),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: widget.ordersData
                                                          ?.pickupPhone !=
                                                      "",
                                                  child: Text(
                                                    widget.ordersData
                                                            ?.pickupPhone ??
                                                        "",
                                                    style: TextStyles()
                                                        .subTitle(
                                                            fontSize: 15,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.6)),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: widget.ordersData
                                                          ?.pickupCity !=
                                                      "",
                                                  child: Text(
                                                    widget.ordersData
                                                            ?.pickupCity ??
                                                        "",
                                                    style: TextStyles()
                                                        .subTitle(
                                                            fontSize: 15,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.6)),
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
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
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
                                                await makeCall(
                                                    number: widget.ordersData
                                                        ?.pickupPhone);
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
                                          //getImages(images: pickUpImages);
                                          _showPicker(context, pickUpImages);
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
                        ),
                        Visibility(
                          visible: widget.ordersData?.pickedAttachmentsModel
                                  ?.isNotEmpty ??
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
                                      itemCount: widget.ordersData
                                          ?.pickedAttachmentsModel?.length,
                                      itemBuilder: (context, i) {
                                        print(
                                            "awwww${widget.ordersData?.pickedAttachmentsModel?[i].pickedAttachment}");
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
                        Visibility(
                          visible: widget.ordersData?.delivery == true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                              (widget.ordersData
                                                              ?.deliveryName ??
                                                          "") !=
                                                      ""
                                                  ? Text(
                                                      widget.ordersData
                                                              ?.deliveryName ??
                                                          "",
                                                      style: TextStyles()
                                                          .subTitle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6)))
                                                  : Container(),
                                              (widget.ordersData?.deliveryAddressNo ??
                                                              "") !=
                                                          "" ||
                                                      (widget.ordersData
                                                                  ?.deliveryAddressName ??
                                                              "") !=
                                                          ""
                                                  ? Text(
                                                      (widget.ordersData
                                                                      ?.deliveryAddressType ??
                                                                  "") ==
                                                              "Apartment"
                                                          ? (widget.ordersData
                                                                  ?.deliveryAddressNo ??
                                                              "")
                                                          : (widget.ordersData
                                                                          ?.deliveryAddressType ??
                                                                      "") ==
                                                                  "Villa"
                                                              ? (widget
                                                                      .ordersData
                                                                      ?.deliveryAddressName ??
                                                                  "")
                                                              : (widget.ordersData
                                                                              ?.deliveryAddressType ??
                                                                          "") ==
                                                                      "Building"
                                                                  ? (widget
                                                                          .ordersData
                                                                          ?.deliveryAddressName ??
                                                                      "")
                                                                  : "",
                                                      style: TextStyles()
                                                          .subTitle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6)),
                                                    )
                                                  : Container(),
                                              // SizedBox(
                                              //   height: 10,
                                              // ),
                                              (widget.ordersData?.deliveryAddressFloor ??
                                                              "") !=
                                                          "" ||
                                                      (widget.ordersData
                                                                  ?.deliveryAddressStreet ??
                                                              "") !=
                                                          ""
                                                  ? Text(
                                                      (widget.ordersData
                                                                      ?.deliveryAddressType ??
                                                                  "") ==
                                                              "Apartment"
                                                          ? (widget.ordersData
                                                                  ?.deliveryAddressFloor ??
                                                              "")
                                                          : (widget.ordersData
                                                                          ?.deliveryAddressType ??
                                                                      "") ==
                                                                  "Villa"
                                                              ? (widget
                                                                      .ordersData
                                                                      ?.deliveryAddressStreet ??
                                                                  "")
                                                              : (widget.ordersData
                                                                              ?.deliveryAddressType ??
                                                                          "") ==
                                                                      "Building"
                                                                  ? (widget
                                                                          .ordersData
                                                                          ?.deliveryAddressFloor ??
                                                                      "")
                                                                  : "",
                                                      style: TextStyles()
                                                          .subTitle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6)),
                                                    )
                                                  : Container(),
                                              Visibility(
                                                visible: widget.ordersData
                                                            ?.deliveryAddressType !=
                                                        "Villa" &&
                                                    ((widget.ordersData
                                                                    ?.deliveryAddressBuilding ??
                                                                "") !=
                                                            "" ||
                                                        (widget.ordersData
                                                                    ?.deliveryAddressStreet ??
                                                                "") !=
                                                            ""),
                                                child: Text(
                                                  widget.ordersData
                                                              ?.deliveryAddressType ==
                                                          "Apartment"
                                                      ? (widget.ordersData
                                                              ?.deliveryAddressBuilding ??
                                                          "")
                                                      : (widget.ordersData
                                                                      ?.deliveryAddressType ??
                                                                  "") ==
                                                              "Building"
                                                          ? (widget.ordersData
                                                                  ?.deliveryAddressStreet ??
                                                              "")
                                                          : "",
                                                  style: TextStyles().subTitle(
                                                      fontSize: 15,
                                                      color: Colors.black
                                                          .withOpacity(0.6)),
                                                ),
                                              ),
                                              Visibility(
                                                visible: widget
                                                            .ordersData?.deliveryAddressType !=
                                                        "Villa" &&
                                                    widget.ordersData
                                                            ?.deliveryAddressType !=
                                                        "Building" &&
                                                    widget.ordersData
                                                            ?.deliveryAddressStreet !=
                                                        "",
                                                child: Text(
                                                  (widget.ordersData
                                                          ?.deliveryAddressStreet ??
                                                      ""),
                                                  style: TextStyles().subTitle(
                                                      fontSize: 15,
                                                      color: Colors.black
                                                          .withOpacity(0.6)),
                                                ),
                                              ),
                                              Text(
                                                widget.ordersData
                                                        ?.deliveryPhone ??
                                                    "",
                                                style: TextStyles().subTitle(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.6)),
                                              ),
                                              Text(
                                                widget.ordersData
                                                        ?.deliveryCity ??
                                                    "",
                                                style: TextStyles().subTitle(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.6)),
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
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MapPage(
                                                              iniLatitude: widget
                                                                  .ordersData
                                                                  ?.deliveryLatitude,
                                                              iniLongitude: widget
                                                                  .ordersData
                                                                  ?.deliveryLongitude,
                                                            )));
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/location.png",
                                                      height: 25,
                                                    ),
                                                    Text(
                                                      "Location",
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
                                            GestureDetector(
                                              onTap: () async {
                                                await makeCall(
                                                    number: widget.ordersData
                                                        ?.deliveryPhone);
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
                                        ),
                                      )
                                    ],
                                  ),
                                  //   margin: EdgeInsets.only(left: 20, right: 20),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
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
                                      onTap: () async {
                                        if (widget.ordersData?.statusId == 2) {
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
                                          _showPicker(context, deliveryImages);
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
                                                            decoration:
                                                                BoxDecoration(
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
                                                                setState(() {});
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
                          height: 20,
                        ),
                        Container(
                          height: 1,
                          child: Divider(
                            thickness: 0.1,
                            color: Colors.black,
                          ),
                        ),
                        Visibility(
                          visible: widget.ordersData?.payType == 2 ||
                              widget.ordersData?.payType == 3,
                          child: Container(
                            //height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.ordersData?.payType == 2
                                          ? "Collect Cash at Pickup"
                                          : "Collect Cash at Delivery",
                                      style: TextStyles().subTitle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "AED ${widget.ordersData?.amount}" ?? "",
                                      style: TextStyles().subTitle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 0.3,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Total Amount",
                                      style: TextStyles().subTitle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "AED ${widget.ordersData?.actualAmount}" ??
                                          "",
                                      style: TextStyles().subTitle(
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
          Visibility(
            visible: isLoading == false,
            child: ButtonWidget(
              onTap: () {
                if (widget.ordersData?.statusId == 6) {
                  showSnackBar(
                      context: context,
                      text: "Admin needs to accept this order");
                }
                if (widget.ordersData?.typeId == 1) {
                  pickUpImages.isNotEmpty && widget.ordersData?.statusId == 2
                      //  &&
                      // (pickUpAmountController.text.isNotEmpty ||
                      //     deliveryAmountController.text.isNotEmpty)
                      ? _bloc.pickedUp(
                          amount: widget.ordersData?.amount ?? "",
                          images: pickUpImages,
                          packageId: widget.ordersData?.id,
                        )
                      : deliveryImages.isNotEmpty &&
                              widget.ordersData?.statusId == 3
                          ? deliveredBloc.delivered(
                              packageId: widget.ordersData?.id,
                              images: deliveryImages,
                              amount: widget.ordersData?.amount ?? "",
                            )
                          : () {};
                }
                if (widget.ordersData?.typeId == 2) {
                  pickUpImages.isNotEmpty && widget.ordersData?.statusId == 3
                      //  &&
                      // (pickUpAmountController.text.isNotEmpty ||
                      //     deliveryAmountController.text.isNotEmpty)
                      ? _bloc.shopOrdersPickedUp(
                          amount: widget.ordersData?.amount ?? "",
                          images: pickUpImages,
                          packageId: widget.ordersData?.id,
                        )
                      : deliveryImages.isNotEmpty &&
                              widget.ordersData?.statusId == 3
                          ? deliveredBloc.shopOrdersdelivered(
                              packageId: widget.ordersData?.id,
                              images: deliveryImages,
                              amount: widget.ordersData?.amount ?? "",
                            )
                          : () {};
                }
              },
              label: widget.ordersData?.statusId == 6
                  ? "Awaiting Payment"
                  : widget.ordersData?.statusId == 2
                      ? "Pick Up"
                      : widget.ordersData?.statusId == 3
                          ? "Deliver"
                          : "",
              borderRadius: 15,
              width: 300,
              height: 55,
            ),
          )
        ],
      )),
    );
  }
}
