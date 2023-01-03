import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

Widget buildListView(reservationList) => ListView.builder(
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
    return const Text("wait for loading data");
  } else if (state is LoadedHome) {
    print("Loaaaaded....");

    return buildListView(BlocProvider.of<HomeCubit>(context)
        .allHomeList[BlocProvider.of<HomeCubit>(context).selectedBottomIndex]);
  } else {
    print("Error Loaaaadingg....");
    return const Text("sorry error");
  }
  print("unknown Loaaaadingg....");
  return const Text("Sorry");
}
