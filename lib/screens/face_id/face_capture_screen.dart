// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import './components/face_camera.dart';
import 'package:ekyc_app/size_config.dart';
import 'package:flutter/material.dart';

class FaceCaptureScreen extends StatelessWidget {
  // const SplashScreen({ Key? key }) : super(key: key);
  static String routeName = "/faceid";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Follow the guide"),
      ),
      body: CameraScreen(),
    );
  }

  void redirect() {}
}
