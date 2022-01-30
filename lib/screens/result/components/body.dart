// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'dart:io';

import 'package:ekyc_app/components/fetch_api.dart';
import 'package:ekyc_app/constants.dart';
import 'package:ekyc_app/size_config.dart';
import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  final AsyncSnapshot<IDCard> _snapshot;
  final List<String> _photos;
  Info(this._snapshot, this._photos);
  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: getProportionateScreenWidth(238),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.file(File(widget._photos[selectedImage])),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(2, (index) => buildSmallPreview(index)),
            ],
          ),
          Container(
            margin: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Liveness check",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Icon(
                  // Icons.check_circle_outline,
                  // color: Colors.green,
                  Icons.cancel_outlined,
                  color: Colors.red,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Verify",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Icon(
                  Icons.check_circle_outline,
                  // Icons.cancel_outlined,
                  color: Colors.green,
                )
              ],
            ),
          ),
          Form(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "ID Number",
                      hintText: widget._snapshot.data!.id,
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Full name",
                      hintText: widget._snapshot.data!.name,
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Date of birth",
                      hintText: widget._snapshot.data!.birthday,
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Hometown",
                      hintText: widget._snapshot.data!.hometown,
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Address",
                      hintText: widget._snapshot.data!.address,
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Issue date",
                      hintText:
                          widget._snapshot.data!.issueDate.replaceAll(' ', '/'),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildSmallPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(15)),
        padding: EdgeInsets.all(getProportionateScreenHeight(8)),
        height: getProportionateScreenHeight(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: selectedImage == index
                    ? kPrimaryColor
                    : kPrimaryLightColor)),
        child: Image.file(File(widget._photos[index])),
      ),
    );
  }
}
