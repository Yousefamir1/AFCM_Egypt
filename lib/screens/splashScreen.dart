import 'dart:async';

 import 'package:animated_widgets/widgets/scale_animated.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'home_screen.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home (),
            )));
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ScaleAnimatedWidget.tween(
                  child: Image.asset(
                    'assets/image/splash_photo.png',
                    width: size.width * 0.70,
                  ),
                  scaleDisabled: 0.3,
                  scaleEnabled: 1,
                  duration: Duration(seconds: 2),
                ),
              ),
              SizedBox(height: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                    Text('RHEUMATOID',style: Theme.of(context).textTheme.headline4,),
                   Text('Detection',style: Theme.of(context).textTheme.headline4,),

                ],
              ),
              Center(child: SpinKitCircle(
                color: Theme.of(context).cardColor,
                size: 50,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
