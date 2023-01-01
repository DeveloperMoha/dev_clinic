import 'package:devclinic/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

import '../../core/utils/font_manager.dart';
import '../../core/utils/strings_manager.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  late String todayDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  int selectedBottomIndex = 1;
  @override
  Widget build(BuildContext context) {
    todayDate = selectedDate.toString().substring(0, 10);
    return Scaffold(
      backgroundColor: ColorManager.mainBgLightColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorManager.blueColor1,
        title: const Text(
          StringManager.homeTitle,
          style: TextStyle(
            fontSize: 28,
            fontFamily: FontManager.abel,
            fontWeight: FontWeight.w900,
            color: ColorManager.whiteColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "${StringManager.homeDate} : $todayDate",
                    style: const TextStyle(
                      fontSize: 25,
                      fontFamily: FontManager.signikaNegativeBold,
                      color: ColorManager.darkGreyColor,
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.mainBgLightColor,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 0),
                    ),
                    child: const Icon(
                      Icons.date_range,
                      size: 35,
                      color: ColorManager.blueColor1,
                    ),
                    onPressed: () {
                      _selectDate(context);
                    }),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              height: 10,
              color: ColorManager.darkGreyColor,
              thickness: 3.0,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorManager.blueColor3,
          currentIndex: selectedBottomIndex,
          selectedItemColor: ColorManager.blueColor1,
          unselectedItemColor: ColorManager.lightGreyColor,
          selectedFontSize: 20,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedFontSize: 18,
          onTap: (value) {
            setState(() {
              selectedBottomIndex = value;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 28),
                label: StringManager.homeBottomBarItem1),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 28),
                label: StringManager.homeBottomBarItem2),
            BottomNavigationBarItem(
                icon: Icon(Icons.sensors_sharp, size: 28),
                label: StringManager.homeBottomBarItem3),
          ]),
    );
  }
}
