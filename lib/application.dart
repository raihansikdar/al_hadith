import 'package:al_hadith/state_binders_controller.dart';
import 'package:al_hadith/ui/screen/bottom_navigation.dart';
import 'package:al_hadith/ui/screen/home_screen.dart';
import 'package:al_hadith/ui/uitility/custom_size_extention.dart';
import 'package:al_hadith/ui/uitility/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlHadith extends StatelessWidget {
  AlHadith({super.key});


  @override
  Widget build(BuildContext context) {

    // Get the screen size
    Size size = MediaQuery.of(context).size;
    // Set the screen width and height in the ScreenSizes utility class
    ScreenSizes.screenWidth = size.width;
    ScreenSizes.screenHeight = size.height;

    return GetMaterialApp(
      initialBinding: StateBinder(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: MaterialColor(AppColors.primaryColor.value, AppColors().color),

      ),
      home: BottomNavigationScreen(),
    );
  }
}