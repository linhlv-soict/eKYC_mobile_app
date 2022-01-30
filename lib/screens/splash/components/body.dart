// ignore_for_file: prefer_const_constructors
import 'package:ekyc_app/screens/face_id/face_capture_screen.dart';
import 'package:ekyc_app/screens/take_idcard_photo/idcard_screen.dart';
import 'package:flutter/material.dart';
import '../../../components/default_button.dart';
import 'package:ekyc_app/constants.dart';
import 'package:ekyc_app/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Text(
                    "eKYC",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(36),
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Welcome to THL eKYC solution!"),
                  Spacer(flex: 2),
                  Image.asset(
                    "assets/images/logo.gif",
                    height: getProportionateScreenHeight(265),
                    // width: getProportionateScreenWidth(600),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  children: <Widget>[
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Get Started",
                      press: () {
                        Navigator.pushNamed(
                            context, FaceCaptureScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
