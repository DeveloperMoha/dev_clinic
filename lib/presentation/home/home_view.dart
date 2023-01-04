import 'package:devclinic/core/utils/color_manager.dart';
import 'package:devclinic/presentation/add_reservation/add_reservation_view.dart';
import 'package:devclinic/presentation/home/home_cubit.dart';
import 'package:devclinic/presentation/home/home_states.dart';
import 'package:devclinic/presentation/home/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/font_manager.dart';
import '../../core/utils/strings_manager.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(create: ((context) {
      return HomeCubit(IntialHomeState());
    }), child: BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${StringManager.homeDate} :\n ${BlocProvider.of<HomeCubit>(context).todayDate}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: FontManager.signikaNegativeBold,
                                color: ColorManager.darkGreyColor,
                              ),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      ColorManager.mainBgLightColor,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 0),
                                ),
                                child: const Icon(
                                  Icons.date_range,
                                  size: 30,
                                  color: ColorManager.blueColor1,
                                ),
                                onPressed: () {
                                  BlocProvider.of<HomeCubit>(context)
                                      .selectDate(context);
                                }),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.mainBgLightColor,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 10),
                                decoration: BoxDecoration(
                                  color: ColorManager.blueColor3,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.add_box,
                                      size: 20,
                                      color: ColorManager.blueColor1,
                                    ),
                                    Text(
                                      "ADD NEW",
                                      style: TextStyle(
                                          color: ColorManager.blueColor1,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const AddReservationScreen()));
                              }),
                        ],
                      ),
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
                Expanded(child: getWidget(state, context)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: ColorManager.blueColor3,
                currentIndex:
                    BlocProvider.of<HomeCubit>(context).selectedBottomIndex,
                selectedItemColor: ColorManager.blueColor1,
                unselectedItemColor: ColorManager.darkGreyColor,
                selectedFontSize: 20,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                unselectedFontSize: 18,
                onTap: (value) {
                  BlocProvider.of<HomeCubit>(context)
                      .changeBottomBarIndex(value);
                  BlocProvider.of<HomeCubit>(context).getAllReservations();
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
          ),
        );
      },
    ));
  }
}
