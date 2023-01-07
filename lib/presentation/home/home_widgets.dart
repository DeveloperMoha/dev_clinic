import 'package:devclinic/core/utils/images_manager.dart';
import 'package:devclinic/core/utils/strings_manager.dart';
import 'package:devclinic/presentation/add_reservation/add_reservation_view.dart';
import 'package:devclinic/presentation/doctor/doctor_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/shared_components.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/font_manager.dart';
import 'home_cubit.dart';
import 'home_states.dart';

Widget listViewItem(id, caseType, patientName, reservationType, date, time,
        paid, context) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        //height: 120,
        decoration: ColorManager.listViewItemDecoration,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorManager.blueColor1,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Text(
                reservationType,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontManager.abel,
                  color: ColorManager.whiteColor,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    child: Text(
                      patientName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontFamily: FontManager.abel,
                        fontWeight: FontWeight.w900,
                        color: ColorManager.whiteColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: FontManager.signikaNegativeLight,
                          color: ColorManager.whiteColor,
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: FontManager.signikaNegativeLight,
                          color: ColorManager.whiteColor,
                        ),
                      ),
                      Text(
                        "paid $paid",
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: FontManager.signikaNegativeLight,
                          color: ColorManager.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: getCaseColor(caseType),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "patient is $caseType",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontManager.abel,
                      color: ColorManager.whiteColor,
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              ColorManager.mainBgLightColor.withOpacity(0.00),
                          elevation: 0,
                          padding: const EdgeInsets.all(10)),
                      child: const Icon(
                        Icons.mode_edit_outline,
                        size: 25,
                        color: ColorManager.whiteColor,
                      ),
                      onPressed: () {
                        //BlocProvider.of<HomeCubit>(context)
                        //  .dialogBuilder(context, id);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget buildListView(reservationList) {
  //print("length is : ${reservationList.length}");

  if (reservationList.length == 0) {
    return const Image(image: AssetImage(ImageManager.noDataFound));
  } else {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: reservationList.length,
      itemBuilder: (context, index) {
        return listViewItem(
            reservationList[index].reservationId,
            reservationList[index].reservationCase,
            reservationList[index].patientName,
            reservationList[index].type,
            reservationList[index].date,
            reservationList[index].time,
            reservationList[index].paid,
            context);
      },
    );
  }
}

// out , exist , in , done
Color getCaseColor(String caseType) {
  switch (caseType) {
    case "done":
      return ColorManager.caseTypeDone;
    case "out":
      return ColorManager.caseTypeOut;
    case "exist":
      return ColorManager.caseTypeExist;
    case "in":
      return ColorManager.caseTypeIn;
    default:
      return ColorManager.caseTypeDone;
  }
}

Container patientCaseEditBtn(title, context, id) => Container(
      width: 200,
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: getCaseColor(title),
              padding:
                  const EdgeInsets.symmetric(horizontal: 60, vertical: 15)),
          child: Text(
            title,
            style:
                const TextStyle(color: ColorManager.whiteColor, fontSize: 20),
          ),
          onPressed: () {
            print("change to $title with id $id");
            //BlocProvider.of<HomeCubit>(context).editPatientCase(title, id);
            print(BlocProvider.of<HomeCubit>(context).selectedDate);
            //Navigator.of(context).pop();
          }),
    );

Widget getWidget(state, context) {
  if (state is LoadingHome) {
    print("Loaaaadingg....");
    return const CircularProgressIndicator(
      color: ColorManager.blueColor1,
      strokeWidth: 2,
    );
  } else if (state is LoadedHome) {
    return buildListView(BlocProvider.of<HomeCubit>(context)
        .allHomeList[BlocProvider.of<HomeCubit>(context).selectedBottomIndex]);
  } else {
    print("Error Loaaaadingg....");
    //return const Image(image: AssetImage(ImageManager.noDataFound));
    return const Text("");
  }
}

// build home drawer
Widget buildDrawer(context) => Drawer(
      child: Container(
        padding: const EdgeInsets.only(top: 0),
        decoration: const BoxDecoration(
          color: ColorManager.blueColor2,
        ),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: const EdgeInsets.only(top: 0),
          children: [
            DrawerHeader(
              padding: const EdgeInsets.only(
                top: 120,
              ),
              margin: const EdgeInsets.only(bottom: 0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageManager.coverImage),
                    fit: BoxFit.cover),
              ),
              child: Container(
                color: ColorManager.blueColor3.withOpacity(.85),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: addingTitleText("Dev Clinic",
                    textSize: 22, titleColor: ColorManager.blackColor),
              ),
            ),
            Container(
              color: ColorManager.blackColor,
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: ColorManager.blackColor.withOpacity(.55),
                  border: const Border(
                      bottom: BorderSide(
                    color: ColorManager.whiteColor,
                    width: 2.0,
                  ))),
              child: ListTile(
                  title: addingTitleText(StringManager.homeDrawerItem1,
                      textSize: 22, titleColor: ColorManager.whiteColor),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const DoctorScreen()));
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: ColorManager.blackColor.withOpacity(.55),
                  border: const Border(
                      bottom: BorderSide(
                    color: ColorManager.whiteColor,
                    width: 2.0,
                  ))),
              child: ListTile(
                  title: addingTitleText(StringManager.homeDrawerItem2,
                      textSize: 22, titleColor: ColorManager.whiteColor),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const AddReservationScreen()));
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: ColorManager.blackColor.withOpacity(.55),
                  border: const Border(
                      bottom: BorderSide(
                    color: ColorManager.whiteColor,
                    width: 2.0,
                  ))),
              child: ListTile(
                  title: addingTitleText(StringManager.homeDrawerItem3,
                      textSize: 22, titleColor: ColorManager.whiteColor),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const AddReservationScreen()));
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: ColorManager.blackColor.withOpacity(.55),
                  border: const Border(
                      bottom: BorderSide(
                    color: ColorManager.whiteColor,
                    width: 2.0,
                  ))),
              child: ListTile(
                  title: addingTitleText(StringManager.homeDrawerItem4,
                      textSize: 22, titleColor: ColorManager.whiteColor),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const AddReservationScreen()));
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: ColorManager.blackColor.withOpacity(.55),
                  border: const Border(
                      bottom: BorderSide(
                    color: ColorManager.whiteColor,
                    width: 2.0,
                  ))),
              child: ListTile(
                  title: addingTitleText(StringManager.homeDrawerItem5,
                      textSize: 22, titleColor: ColorManager.whiteColor),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const AddReservationScreen()));
                  }),
            ),
          ],
        ),
      ),
    );

Widget buildLeading(scaffoldKey) => IconButton(
      icon: const Icon(Icons.menu_sharp),
      onPressed: () => scaffoldKey.currentState.openDrawer(),
    );
