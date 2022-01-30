// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import '../result/result_screen.dart';

import './components/body.dart';
import 'package:flutter/material.dart';

class TakeIDCardPhotoScreen extends StatefulWidget {
  static String routeName = "/idcard";

  @override
  State<TakeIDCardPhotoScreen> createState() => _TakeIDCardPhotoScreenState();
}

class _TakeIDCardPhotoScreenState extends State<TakeIDCardPhotoScreen> {
  String _frontIdCardImgPath = "";
  String _backIdCardImgPath = "";

  void _saveImg(String path) {
    if (_frontIdCardImgPath.isEmpty) {
      setState(() {
        _frontIdCardImgPath = path;
        Navigator.of(context).pop();
      });
    } else {
      setState(() {
        _backIdCardImgPath = path;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ResultScreen(_frontIdCardImgPath, _backIdCardImgPath)),
      );
    }

    print(_frontIdCardImgPath);
    print(_backIdCardImgPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (_frontIdCardImgPath.isEmpty)
            ? Text("Take ID Card's FRONT photo")
            : Text("Take ID Card's BACK photo"),
      ),
      body: CameraScreen(_saveImg),
    );
  }
}
