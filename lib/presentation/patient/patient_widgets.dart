import 'package:devclinic/presentation/patient/patient_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/shared_components.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/font_manager.dart';
import '../../core/utils/images_manager.dart';
import '../../core/utils/strings_manager.dart';

AppBar patientAppBar(context) => AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: ColorManager.blueColor1,
      title: const Text(
        StringManager.patientAppBarTitle,
        style: TextStyle(
          fontSize: 22,
          fontFamily: FontManager.abel,
          fontWeight: FontWeight.w900,
          color: ColorManager.whiteColor,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.whiteColor,
            ),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => AddDoctorScreen()));
            },
            child: Row(
              children: [
                addingTitleText("Add New   ",
                    titleColor: ColorManager.blackColor,
                    textSize: 22,
                    fontfamily: FontManager.signikaNegativeBold),
                const Icon(
                  Icons.add_box,
                  color: ColorManager.blueColor1,
                  size: 24,
                )
              ],
            ),
          ),
        )
      ],
    );

BottomNavigationBar buildPatientBottomBar(context) {
  return BottomNavigationBar(
      backgroundColor: ColorManager.lightGreyColor,
      currentIndex: BlocProvider.of<PatientCubit>(context).selectedSortIndex,
      selectedItemColor: ColorManager.blueColor1,
      unselectedItemColor: ColorManager.darkGreyColor,
      selectedFontSize: 18,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedFontSize: 18,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        BlocProvider.of<PatientCubit>(context).changeSelectedIndex(value);
        BlocProvider.of<PatientCubit>(context).getOrderedPatientData();
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.date_range, size: 25),
            label: StringManager.patientBottomBarItem1),
        BottomNavigationBarItem(
            icon: Icon(Icons.abc, size: 25),
            label: StringManager.patientBottomBarItem2),
        BottomNavigationBarItem(
            icon: Icon(Icons.twenty_mp, size: 25),
            label: StringManager.patientBottomBarItem3),
        BottomNavigationBarItem(
            icon: Icon(Icons.stream_outlined, size: 28),
            label: StringManager.patientBottomBarItem4),
      ]);
}

Widget patientListViewItem(
        id, name, age, address, phone, education, socialStatue, context) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        //height: 120,
        decoration: ColorManager.doctorListViewItemDecoration,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        child: addingTitleText(name,
                            fontfamily: FontManager.abel,
                            textSize: 26,
                            titleColor: ColorManager.blackColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        child: addingTitleText("Address : $address",
                            fontfamily: FontManager.abel,
                            textSize: 26,
                            titleColor: ColorManager.blackColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        child: addingTitleText("Phone : $phone",
                            fontfamily: FontManager.abel,
                            textSize: 26,
                            titleColor: ColorManager.blackColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        child: addingTitleText("Age :  $age",
                            fontfamily: FontManager.abel,
                            textSize: 20,
                            titleColor: ColorManager.blackColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        child: addingTitleText("Education : \n $education",
                            fontfamily: FontManager.abel,
                            textSize: 20,
                            titleColor: ColorManager.blackColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        child: addingTitleText(
                            "Social statue : \n $socialStatue",
                            fontfamily: FontManager.abel,
                            textSize: 20,
                            titleColor: ColorManager.blackColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

Widget buildPatientListView(patientList) {
  if (patientList.length == 0) {
    return const Image(image: AssetImage(ImageManager.noDataFound));
  } else {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: patientList.length,
      itemBuilder: (context, index) {
        return patientListViewItem(
            patientList[index].patientId,
            patientList[index].patientName,
            patientList[index].patientAge.toString(),
            patientList[index].patientAddress,
            patientList[index].patientPhone,
            patientList[index].patientEducation,
            patientList[index].patientSocialStatue,
            context);
      },
    );
  }
}
