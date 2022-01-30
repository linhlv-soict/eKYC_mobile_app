// ignore_for_file: prefer_const_constructors

import 'package:ekyc_app/routs.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './constants.dart';
import './screens/splash/splash_screen.dart';
import './screens/face_id/face_capture_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eKYC',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Muli",
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          // brightness: Brightness.light,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: IconThemeData(color: Colors.black),
          // textTheme: TextTheme(
          //   headline6: TextStyle(color: Color(0xFF8B8B8B), fontSize: 18),
          // ),
          titleTextStyle: TextStyle(color: Color(0xFF8B8B8B), fontSize: 18),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: kTextColor),
          bodyText2: TextStyle(color: kTextColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: kPrimaryColor, fontSize: 20),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreen.routeName,
      routes: routes,
      // home: SplashScreen(),
    );
  }
}
