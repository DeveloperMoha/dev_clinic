import 'package:devclinic/presentation/add_reservation/add_reservation_widgets.dart';
import 'package:devclinic/presentation/add_reservation/reservation_cubit.dart';
import 'package:devclinic/presentation/add_reservation/reservation_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/shared_components.dart';
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
    var media = MediaQuery.of(context);
    return BlocProvider<ReservationCubit>(create: (context) {
      return ReservationCubit(IntialReservationState());
    }, child: BlocBuilder<ReservationCubit, ReservationStates>(
        builder: (context, state) {
      var cubitObj = BlocProvider.of<ReservationCubit>(context);

      return Scaffold(
        backgroundColor: ColorManager.mainBgLightColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: ColorManager.blueColor1,
          title: const Text(
            StringManager.addReservationTitle,
            style: TextStyle(
              fontSize: 22,
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
                      addingTitleText("Reservation Type : ", textSize: 18),
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
                                fontSize: 20,
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
                      addingTitleText("Patient Name : ", textSize: 18),
                      addingAutoCompleteTextField(cubitObj.patientNamesList,
                          media.size.width * (2 / 5), context),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      addingTitleText("Date ", textSize: 16),
                      addingTitleText(cubitObj.todayDate.toString(),
                          textSize: 16, titleColor: ColorManager.blueColor2),
                      addingDateBtn(context),
                      const SizedBox(
                        width: 10,
                      ),
                      addingTitleText("Time ", textSize: 16),
                      addingTitleText(cubitObj.todayTime.toString(),
                          textSize: 16, titleColor: ColorManager.blueColor2),
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
                                    fontSize: 18,
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
                                    fontSize: 18,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  addingTitleText("Patient Name  ",
                                      textSize: 18),
                                  addingTextFormField(
                                      TextInputType.text,
                                      media.size.width * (.5),
                                      cubitObj.paitientNameController),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  addingTitleText("age ", textSize: 18),
                                  addingTextFormField(TextInputType.number, 35,
                                      cubitObj.paitientAgeController),
                                ],
                              ),
                              Row(
                                children: [
                                  addingTitleText("  address  ", textSize: 18),
                                  addingTextFormField(
                                      TextInputType.text,
                                      media.size.width * (.4),
                                      cubitObj.paitientAddressController),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  addingTitleText("phone ", textSize: 12),
                                  addingTextFormField(TextInputType.number, 70,
                                      cubitObj.paitientPhoneController),
                                ],
                              ),
                              Row(
                                children: [
                                  addingTitleText("  eduacation  ",
                                      textSize: 14),
                                  addingTextFormField(
                                      TextInputType.text,
                                      media.size.width * (.25),
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
                                  addingTextFormField(
                                      TextInputType.text,
                                      media.size.width * (.5),
                                      cubitObj.paitientsocialStatueController),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (patientFormKey.currentState!.validate()) {
                                  cubitObj.addNewPatient();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Patient Data inserted successfully')),
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30),
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
                    height: 10,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          addingTitleText("specification  ", textSize: 18),
                          addingTextFormField(
                              TextInputType.text,
                              media.size.width * (.5),
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
                          addingTextFormField(
                              TextInputType.text,
                              media.size.width * (.5),
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
                      addingTextAreaField(media.size.width * (.6),
                          cubitObj.paitientNotesController),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (patientFormKey.currentState!.validate()) {
                          cubitObj.addNewReservation();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Reservation Data inserted successfully')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('sorry plz fill required fields')),
                          );
                        }
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
