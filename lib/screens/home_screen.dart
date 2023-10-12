import 'dart:io';
import 'package:afcm_egypt/color.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import '../main.dart';
import '../widget/custom_container.dart';
import 'package:image/image.dart' as img;

import 'ResultScreen.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool _loading = true;
  late File _image;
  final imagePicker = ImagePicker();
  List predictions = [];
  bool isWorking = false;
  String result = '';
  CameraController? cameraController;
  CameraImage? cameraImage;
   bool darkMode = false;

  IconData iconLight = Icons.wb_sunny;
  IconData iconDark = Icons.nights_stay;



  // Add a variable to track dark mode.

  File applyGrayscaleFilter(File inputImage) {
    final image = img.decodeImage(inputImage.readAsBytesSync())!;
    final grayscaleImage = img.grayscale(image);

    final filteredImage =
        File(inputImage.path.replaceAll('.jpg', '_grayscale.jpg'))
          ..writeAsBytesSync(img.encodeJpg(grayscaleImage));

    return filteredImage;
  }

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController?.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        cameraController?.startImageStream((imageFromStream) {
          if (!isWorking) {
            isWorking = true;
            cameraImage = imageFromStream;
            runModelOnFrame();
          }
        });
      });
    });
  }

  loadImageGallery() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      final filteredImage = applyGrayscaleFilter(File(image.path));
      _image = filteredImage;
    }
    runModelImage(_image);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          image: _image,
          predictions: predictions,
        ),
      ),
    );
  }

  loadImageCamera() async {
    var image = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);
    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    runModelImage(_image);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          image: _image,
          predictions: predictions,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
  }

  @override
  void dispose() async {
    super.dispose();
    await Tflite.close();
    cameraController?.dispose();
  }

  runModelImage(File image) async {
    var prediction = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 3,
        threshold: .7,
        imageStd: 100,
        imageMean: 100);

    setState(() {
      _loading = false;
      predictions = prediction!;
    });
  }

  runModelOnFrame() async {
    if (cameraImage != null) {
      var recognition = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,

        //defaults to 127.5
        imageStd: 127.5,
        //defaults to 127.5
        rotation: 90,
        // defaults to 90, Android only
        numResults: 3,
        // defaults to 5
        threshold: 0.7,
        // defaults to 0.1
        asynch: true,
        // defaults to true
      );

      result = '';
      recognition?.forEach((response) {
        result += response['label'] +
            " " +
            (response['confidence'] as double).toStringAsFixed(1) +
            "\n\n";
      });

      setState(() {
        result;
      });
      isWorking = false;
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model.tflite',
        labels: 'assets/labels.txt',
        isAsset: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: MainColor.primaryColor,
        appBar: AppBar(
          title:   Text('ML Classifier'),
          actions: [
            IconButton(
                onPressed: (){
                  setState(() {

                    darkMode= !darkMode;

                  });
                  ThemeService().changeTheme();

                },
                icon:Icon(
                  darkMode? CupertinoIcons.moon_stars
                      :CupertinoIcons.sun_max
                 )
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 120,
                width: 130,
                child: Image.asset(
                  'assets/image/logo.png',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
               Text(
                'Rheumatoid Detector',
                style:Theme.of(context).textTheme.headline6

              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Column(
                  children: [
                    CustomContainer(
                      text: 'Gallery',
                      onPressed: () {
                        cameraImage = null;
                        loadImageGallery();
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomContainer(
                      text: 'Camera',
                      onPressed: () {
                        cameraImage = null;
                        loadImageCamera();
                      },
                    ),

                  ],
                ),
              )
            ],
          ),
        ));
  }
}
// const SizedBox(
//   height: 12,
// ),
// CustomContainer(
//   text: 'Live Detection',
//   onPressed: () {
//     initCamera();
//   },
// ),