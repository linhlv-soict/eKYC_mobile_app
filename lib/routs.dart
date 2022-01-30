import 'package:ekyc_app/screens/face_id/face_capture_screen.dart';
import 'package:ekyc_app/screens/result/result_screen.dart';
import 'package:ekyc_app/screens/splash/splash_screen.dart';
import 'package:ekyc_app/screens/take_idcard_photo/idcard_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  TakeIDCardPhotoScreen.routeName: (context) => TakeIDCardPhotoScreen(),
  FaceCaptureScreen.routeName: (context) => FaceCaptureScreen(),
};
