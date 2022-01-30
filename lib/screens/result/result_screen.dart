// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:ekyc_app/screens/result/components/body.dart';
import 'package:ekyc_app/size_config.dart';
import 'package:flutter/material.dart';
import '../../components/fetch_api.dart';

class ResultScreen extends StatefulWidget {
  // const SplashScreen({ Key? key }) : super(key: key);
  final String _frontIdCardImgPath;
  final String _backIdCardImgPath;

  ResultScreen(this._frontIdCardImgPath, this._backIdCardImgPath);
  static String routeName = "/result";

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Future<IDCard> futureCard;

  @override
  void initState() {
    super.initState();
    futureCard =
        fetchIdCard(widget._frontIdCardImgPath, widget._backIdCardImgPath);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Check result"),
      ),
      body: SafeArea(
        child: FutureBuilder<IDCard>(
            future: futureCard,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Info(snapshot,
                    [widget._frontIdCardImgPath, widget._backIdCardImgPath]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/loading.gif",
                    fit: BoxFit.fitWidth,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
