// ignore_for_file: avoid_print, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:ekyc_app/constants.dart';
import 'package:ekyc_app/screens/take_idcard_photo/idcard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../size_config.dart';

class CameraScreen extends StatefulWidget {
  // final Function saveImg;

  // CameraScreen(this.saveImg);

  @override
  _CameraScreenState createState() {
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late List cameras;
  late int selectedCameraIdx;
  late String imagePath;
  bool isStarted = false;

  late Timer _timer;
  int _start = 6;
  int _countDown = 19;
  // void _saveImgPath(String path) {
  //   widget.saveImg(path);
  // }

  List<String> _guide = ['Keep straight', 'Turn right >>>', '<<< Turn left'];
  int _idx = 0;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras.isNotEmpty) {
        setState(() {
          selectedCameraIdx = 1;
        });

        _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    // if (controller != null) {
    //   await controller.dispose();
    // }

    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //padding: EdgeInsets.only(top: 25),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _cameraPreviewWidget(),
              Opacity(
                opacity: 0.5,
                child: Image.asset(
                  "assets/images/face.png",
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Spacer(flex: 1),
                  Text(
                    "Keep your face inside the circle",
                    style: TextStyle(color: kPrimaryLightColor, fontSize: 18),
                  ),
                  Spacer(flex: 13),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(flex: 7),
                  Text(
                    _guide[_idx],
                    style: TextStyle(color: kPrimaryColor, fontSize: 35),
                  ),
                  Spacer(flex: 1),
                  isStarted
                      ? Expanded(
                          child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            _start.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ))
                      : _captureControlRowWidget(context),
                  Spacer(flex: 1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Display Camera preview.
  Widget _cameraPreviewWidget() {
    if (!controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    // ClipRRect(
    //   borderRadius: BorderRadius.only(
    //     topLeft: Radius.circular(8.0),
    //     topRight: Radius.circular(8.0),
    //     bottomRight: Radius.circular(8.0),
    //     bottomLeft: Radius.circular(8.0),
    //   ),
    //   child: AspectRatio(
    //     aspectRatio: controller.value.aspectRatio,
    //     child: CameraPreview(controller),
    //   ),
    // );

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }

  /// Display the control bar with buttons to take pictures
  Widget _captureControlRowWidget(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: getProportionateScreenHeight(56 * 3),
          height: getProportionateScreenHeight(56),
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              startTimer(context);
              _onCapturePressed(context);
            },
            child: Text(
              "Start",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onCapturePressed(context) async {
    setState(() {
      isStarted = true;
    });
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Attempt to take a picture and log where it's been saved
      final path = join(
        // In this example, store the picture in the temp directory. Find
        // the temp directory using the `path_provider` plugin.
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      final ximg = await controller.takePicture();
      print(ximg.path);
      // If the picture was taken, display it on a new scree

    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    print('Error: ${e.code}\n${e.description}');
  }

  void startTimer(context) {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countDown == 0) {
          setState(() {
            timer.cancel();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TakeIDCardPhotoScreen()),
            );
          });
        } else {
          setState(() {
            _start--;
            _countDown--;
          });
          if (_start == 0) {
            // playLocalAsset();
            _start = 7;
            _idx++;
          }
        }
      },
    );
  }
}

// Future<AudioPlayer> playLocalAsset() async {
//   AudioCache cache = AudioCache();
//   //At the next line, DO NOT pass the entire reference such as assets/yes.mp3. This will not work.
//   //Just pass the file name only.
//   return await cache.play("/assets/sounds/camera.wav");
// }
