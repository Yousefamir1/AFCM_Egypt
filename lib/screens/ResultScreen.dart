import 'dart:io';

import 'package:flutter/material.dart';


class ResultScreen extends StatelessWidget {
  final File image;
  final List<dynamic> predictions;

  ResultScreen({required this.image, required this.predictions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4.0,
                  color: Theme.of(context).cardColor,
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.47,
              child: Image.file(image),
            ),
          ),
          SizedBox(height: 20),
          if (predictions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(predictions[0]['label'].toString().substring(1),
                      style: Theme.of(context).textTheme.subtitle2),
                  Text("Confidence: ${predictions[0]["confidence"]}",
                      style: Theme.of(context).textTheme.subtitle2)
                ],
              ),
            )
          else
            SizedBox(
              height: 55,
              child: Text("No predictions available",
                  style: Theme.of(context).textTheme.headline6),
            ),
        ],
      ),
    );
  }
}
