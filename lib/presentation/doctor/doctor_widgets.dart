import 'package:devclinic/core/components/shared_components.dart';
import 'package:devclinic/domain/entities/doctor.dart';
import 'package:devclinic/presentation/doctor/add_doctor_view.dart';
import 'package:flutter/material.dart';

import '../../core/utils/color_manager.dart';
import '../../core/utils/font_manager.dart';
import '../../core/utils/images_manager.dart';
import '../../core/utils/strings_manager.dart';

AppBar doctorAppBar(context) => AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: ColorManager.blueColor1,
      title: const Text(
        StringManager.doctorAppBarTitle,
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AddDoctorScreen()));
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

Widget doctorListViewItem(id, name, age, phone, specification, context) =>
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
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 29,
                        fontFamily: FontManager.abel,
                        fontWeight: FontWeight.w900,
                        color: ColorManager.blackColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "phone :\n ${phone}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: FontManager.signikaNegativeLight,
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "age : ${age.toString()}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: FontManager.signikaNegativeLight,
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          specification,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: FontManager.signikaNegativeLight,
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.mainBgLightColor
                                    .withOpacity(0.9),
                                elevation: 0,
                                padding: const EdgeInsets.all(10)),
                            child: Row(
                              children: [
                                addingTitleText("edit  ",
                                    titleColor: ColorManager.blackColor,
                                    textSize: 22,
                                    fontfamily:
                                        FontManager.signikaNegativeBold),
                                const Icon(
                                  Icons.edit,
                                  color: ColorManager.blueColor1,
                                  size: 24,
                                )
                              ],
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddDoctorScreen.addDoctor(
                                        id: id,
                                        name: name,
                                        age: age,
                                        phone: phone,
                                        specification: specification,
                                      )));
                            }),
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

Widget buildDoctorListView(reservationList) {
  if (reservationList.length == 0) {
    return const Image(image: AssetImage(ImageManager.noDataFound));
  } else {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: reservationList.length,
      itemBuilder: (context, index) {
        return doctorListViewItem(
            reservationList[index].id,
            reservationList[index].doctorName,
            reservationList[index].age,
            reservationList[index].phone,
            reservationList[index].specification,
            context);
      },
    );
  }
}

AppBar addDoctorAppBar(context, nameController, ageController, phoneController,
        specificationController, cubitObj) =>
    AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: ColorManager.blueColor1,
      title: const Text(
        StringManager.addDoctorAppBarTitle,
        style: TextStyle(
          fontSize: 20,
          fontFamily: FontManager.abel,
          fontWeight: FontWeight.w900,
          color: ColorManager.whiteColor,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              cubitObj.resetForms(nameController, ageController,
                  phoneController, specificationController);
            },
            icon: const Icon(
              Icons.delete,
              size: 28,
            ))
      ],
    );

Widget buildAddDoctorBody(idController, nameController, ageController,
    phoneController, specificationController, context, id, formKey, cubitObj) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: addingTitleText("Doctor Information",
                fontfamily: FontManager.signikaNegativeBold,
                textSize: 28,
                titleColor: ColorManager.blueColor1),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                addingTitleText("Name  :   "),
                addingSharedTextFormField(
                    TextInputType.text, nameController, 250.0)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                addingTitleText("age  :       "),
                addingSharedTextFormField(
                    TextInputType.number, ageController, 250.0)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                addingTitleText("Phone :   "),
                addingSharedTextFormField(
                    TextInputType.text, phoneController, 250.0)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                addingTitleText("Specification  :   "),
                addingSharedTextFormField(
                    TextInputType.text, specificationController, 180.0)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.blueColor1.withOpacity(0.9),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15)),
                child: addingTitleText(
                    ((id == 0) ? "Add Doctor" : "Edit Doctor"),
                    titleColor: ColorManager.whiteColor,
                    textSize: 22,
                    fontfamily: FontManager.signikaNegativeBold),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (id == 0) {
                      cubitObj.addNewDoctor(
                        Doctor(
                            id: idController,
                            doctorName: nameController.text,
                            age: int.parse(ageController.text),
                            phone: phoneController.text,
                            specification: specificationController.text),
                      );
                      cubitObj.resetForms(nameController, ageController,
                          phoneController, specificationController);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Doctor information inserted successfully')),
                      );
                    } else {
                      cubitObj.updateDoctor(
                        Doctor(
                            id: idController,
                            doctorName: nameController.text,
                            age: int.parse(ageController.text),
                            phone: phoneController.text,
                            specification: specificationController.text),
                      );
                      cubitObj.resetForms(nameController, ageController,
                          phoneController, specificationController);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Doctor information updated successfully')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('sorry plz fill required fields')),
                    );
                  }
                }),
          ),
        ],
      ),
    ),
  );
}
