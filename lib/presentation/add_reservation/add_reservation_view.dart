import 'package:devclinic/presentation/add_reservation/add_reservation_widgets.dart';
import 'package:devclinic/presentation/add_reservation/reservation_cubit.dart';
import 'package:devclinic/presentation/add_reservation/reservation_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/color_manager.dart';
import '../../core/utils/font_manager.dart';
import '../../core/utils/strings_manager.dart';

class AddReservationScreen extends StatefulWidget {
  const AddReservationScreen({super.key});

  @override
  State<AddReservationScreen> createState() => _AddReservationScreenState();
}

class _AddReservationScreenState extends State<AddReservationScreen> {
  final formKey = GlobalKey<FormState>();
  final patientFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReservationCubit>(create: (context) {
      return ReservationCubit(IntialReservationState());
    }, child: BlocBuilder<ReservationCubit, ReservationStates>(
        builder: (context, state) {
      var cubitObj = BlocProvider.of<ReservationCubit>(context);

      return Scaffold(
        backgroundColor: ColorManager.mainBgLightColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorManager.blueColor1,
          title: const Text(
            StringManager.addReservationTitle,
            style: TextStyle(
              fontSize: 28,
              fontFamily: FontManager.abel,
              fontWeight: FontWeight.w900,
              color: ColorManager.whiteColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      addingTitleText("Reservation Type : "),
                      DropdownButton<String>(
                        value: cubitObj.reservationTypeValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(color: ColorManager.blueColor2),
                        underline: Container(
                          height: 1,
                          color: ColorManager.blueColor1,
                        ),
                        onChanged: (String? value) {
                          BlocProvider.of<ReservationCubit>(context)
                              .selectReservationType(value);
                          print("hello : $value");
                        },
                        items: cubitObj.reservationType
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      addingTitleText("Patient Name : "),
                      addingAutoCompleteTextField(
                          cubitObj.reservationType, 200.0),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      addingTitleText("Date ", textSize: 18),
                      addingTitleText(cubitObj.todayDate.toString(),
                          textSize: 18, titleColor: ColorManager.blueColor2),
                      addingDateBtn(context),
                      const SizedBox(
                        width: 10,
                      ),
                      addingTitleText("Time ", textSize: 18),
                      addingTitleText(cubitObj.todayTime.toString(),
                          textSize: 18, titleColor: ColorManager.blueColor2),
                      addingTimeBtn(context, icon: Icons.timer),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          addingTitleText("Price ", textSize: 18),
                          addingCalculatedTextFormField(TextInputType.number,
                              50, cubitObj.priceController, context),
                        ],
                      ),
                      Row(
                        children: [
                          addingTitleText("Paid ", textSize: 18),
                          addingCalculatedTextFormField(
                            TextInputType.number,
                            50,
                            cubitObj.paidController,
                            context,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          addingTitleText("Rest ", textSize: 18),
                          addingTextFormField(
                              TextInputType.number, 50, cubitObj.restController,
                              enable: false),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          addingTitleText("Doctor :  ", textSize: 18),
                          DropdownButton<String>(
                            value: cubitObj.doctorNameValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            style:
                                const TextStyle(color: ColorManager.blueColor2),
                            underline: Container(
                              height: 1,
                              color: ColorManager.blueColor1,
                            ),
                            onChanged: (String? value) {
                              BlocProvider.of<ReservationCubit>(context)
                                  .selectDoctorNam(value);
                            },
                            items: cubitObj.doctorNamesList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          addingTitleText("Res-Case :  ", textSize: 18),
                          DropdownButton<String>(
                            value: cubitObj.reservationCaseValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            style:
                                const TextStyle(color: ColorManager.blueColor2),
                            underline: Container(
                              height: 1,
                              color: ColorManager.blueColor1,
                            ),
                            onChanged: (String? value) {
                              BlocProvider.of<ReservationCubit>(context)
                                  .selectReseravtionCase(value);
                              print("hello : $value");
                            },
                            items: cubitObj.reservationCase
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: ColorManager.lightGreyColor,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Form(
                      key: patientFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addingTitleText("Patient Section :  ", textSize: 22),
                          Row(
                            children: [
                              Row(
                                children: [
                                  addingTitleText("Patient Name  ",
                                      textSize: 18),
                                  addingTextFormField(TextInputType.text, 240,
                                      cubitObj.paitientNameController),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  addingTitleText("age ", textSize: 18),
                                  addingTextFormField(TextInputType.number, 40,
                                      cubitObj.paitientAgeController),
                                ],
                              ),
                              Row(
                                children: [
                                  addingTitleText("address  ", textSize: 18),
                                  addingTextFormField(TextInputType.text, 200,
                                      cubitObj.paitientAddressController),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  addingTitleText("phone ", textSize: 16),
                                  addingTextFormField(TextInputType.number, 80,
                                      cubitObj.paitientPhoneController),
                                ],
                              ),
                              Row(
                                children: [
                                  addingTitleText("eduacation  ", textSize: 16),
                                  addingTextFormField(TextInputType.text, 140,
                                      cubitObj.paitientEducationController),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  addingTitleText("social-statue ",
                                      textSize: 18),
                                  addingTextFormField(TextInputType.text, 250,
                                      cubitObj.paitientsocialStatueController),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  addingTitleText("specification  ",
                                      textSize: 18),
                                  addingTextFormField(TextInputType.text, 245,
                                      cubitObj.paitientSpecificationController),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  addingTitleText("medicine  ", textSize: 18),
                                  addingTextFormField(TextInputType.text, 275,
                                      cubitObj.paitientMedicineController),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addingTitleText("notes    ", textSize: 20),
                              addingTextAreaField(
                                  290, cubitObj.paitientNotesController),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (patientFormKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Now U can insert Data')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'sorry plz fill required fields')),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.blueColor1,
                              ),
                              child: addingTitleText("Add New Patient",
                                  titleColor: ColorManager.whiteColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // if (formKey.currentState!.validate()) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //         content: Text('Now U can insert Data')),
                        //   );
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //         content:
                        //             Text('sorry plz fill required fields')),
                        //   );
                        // }
                        cubitObj.testFun();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.blueColor2,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10)),
                      child: addingTitleText("Save Reservation",
                          titleColor: ColorManager.whiteColor, textSize: 28),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }));
  }
}
