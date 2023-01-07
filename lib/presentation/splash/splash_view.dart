import 'package:devclinic/core/utils/color_manager.dart';
import 'package:devclinic/core/utils/font_manager.dart';
import 'package:devclinic/core/utils/images_manager.dart';
import 'package:devclinic/core/components/shared_components.dart';
import 'package:devclinic/core/utils/strings_manager.dart';
import 'package:devclinic/presentation/home/home_view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: ColorManager.blueColor1,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.3, 0.8],
            colors: [
              ColorManager.blueColor1,
              ColorManager.blueColor2,
              ColorManager.blueColor3,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(ImageManager.splashLogo),
              width: 100,
              height: 120,
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              StringManager.appTitle,
              style: TextStyle(
                fontSize: 35,
                fontFamily: FontManager.abel,
                fontWeight: FontWeight.w900,
                color: ColorManager.whiteColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              StringManager.splashHeadText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontFamily: FontManager.signikaNegativeLight,
                color: ColorManager.lightGreyColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.blueColor2,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    StringManager.splashBtn,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: FontManager.signikaNegativeLight,
                      color: ColorManager.lightGreyColor,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen()));
                })
          ],
        ),
      ),
    );
  }
}
