import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loridriverflutterapp/bloc/contact_us_bloc.dart';
import 'package:loridriverflutterapp/widgets/button_widget.dart';
import 'package:loridriverflutterapp/widgets/snackbar_widget.dart';

import '../helpers/api_helper.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/toast_widget.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactUsBloc bloc = ContactUsBloc();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController commentContoller = TextEditingController();

  contactUs() {
    bloc.contactUsStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          showToast(msg: "Thank You");

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainBottomNavBar()));
          setState(() {});
          break;
        case Status.ERROR:
          setState(() {});
          break;
      }
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.42796133580664, 45.085749655962),
    zoom: 3.4746,
  );

  final Set<Marker> _markers = {};

  onMapCreated() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("id-1"),
        position: LatLng(24.42796133580664, 45.085749655962),
      ));
    });
  }

  showToast({msg}) async {
    await toastWidget(
        bgColor: Colors.grey, textColor: Colors.white, msg: msg ?? "");
  }

  @override
  void initState() {
    contactUs();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
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
                      Text("CONTACT",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 650,
              child: Stack(
                children: [
                  Container(
                      height: 650,
                      child: GoogleMap(
                        zoomControlsEnabled: false,
                        markers: _markers,
                        onMapCreated: onMapCreated(),
                        initialCameraPosition: _kGooglePlex,
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 11),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.white),
                        padding: EdgeInsets.only(left: 23, right: 23),
                        height: 450, width: 300,
                        //margin: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Contact Us",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            textField(
                              image: "assets/images/user.png",
                              controller: nameController,
                              label: "Name",
                            ),
                            textField(
                                image: "assets/images/comment.png",
                                label: "Email",
                                controller: emailController),
                            textField(
                                image: "assets/images/comment.png",
                                label: "Phone",
                                keyboardType: TextInputType.number,
                                controller: phoneController),
                            textField(
                                image: "assets/images/comment.png",
                                label: "Comment...",
                                controller: commentContoller),
                            SizedBox(
                              height: 15,
                            ),
                            ButtonWidget(
                              label: "SUBMIT",
                              onTap: () async {
                                await bloc?.contactUs(
                                    email: emailController.text,
                                    description: commentContoller.text,
                                    phone: phoneController.text,
                                    name: nameController.text);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

textField({controller, label, image, TextInputType? keyboardType}) {
  return Column(
    children: [
      TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
            isDense: true,
            prefixIconConstraints: BoxConstraints(minWidth: 0),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            label: Text(
              label,
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: "Open Sans",
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            prefixIcon: Container(
              transform: Matrix4.translationValues(-14.0, 0.0, 0.0),
              child: IconTheme(
                  data: IconThemeData(
                    color: Colors.grey,
                  ),
                  child: IconButton(
                      onPressed: null,
                      icon: Image.asset(
                        image,
                        height: 25,
                        width: 25,
                        color: Colors.black.withOpacity(0.8),
                      ))),
            )),
      ),
      SizedBox(
        height: 15,
      )
    ],
  );
}
