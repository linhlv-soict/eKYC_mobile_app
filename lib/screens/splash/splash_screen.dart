// ignore_for_file: prefer_const_constructors

import 'package:ekyc_app/size_config.dart';
import 'package:flutter/material.dart';

import './components/body.dart';

class SplashScreen extends StatelessWidget {
  // const SplashScreen({ Key? key }) : super(key: key);
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      // appBar: AppBar(),
      body: Body(),
    );
  }
}
