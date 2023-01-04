import 'package:devclinic/core/utils/color_manager.dart';
import 'package:devclinic/presentation/add_reservation/reservation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/patient.dart';

Widget dropDownMenu(dropList, dropValue, context) {
  var cubitObj = BlocProvider.of<ReservationCubit>(context);
  return DropdownButton<String>(
    value: dropValue,
    icon: const Icon(Icons.arrow_drop_down),
    style: const TextStyle(color: ColorManager.blueColor2),
    underline: Container(
      height: 1,
      color: ColorManager.blueColor1,
    ),
    onChanged: (String? value) {
      BlocProvider.of<ReservationCubit>(context).selectReservationType(value);
      print("hello : ${dropValue}");
    },
    items: dropList.map<DropdownMenuItem<String>>((String value) {
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
  );
}

Widget addingTitleText(String title,
    {double textSize = 20.0, titleColor = ColorManager.darkGreyColor}) {
  return Text(
    title,
    style: TextStyle(
      fontSize: textSize,
      color: titleColor,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget addingAutoCompleteTextField(list, autoCompWidth, context) {
  return Container(
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.person,
            size: 20,
          ),
          SizedBox(
            width: autoCompWidth,
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return list.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                BlocProvider.of<ReservationCubit>(context).patientName =
                    selection;

                int index = BlocProvider.of<ReservationCubit>(context)
                    .patientNamesList
                    .indexOf(selection);
                BlocProvider.of<ReservationCubit>(context)
                    .setControllerValues(context, index);
              },
            ),
          ),
        ],
      ));
}

Widget addingDateBtn(
  context, {
  var icon = Icons.date_range,
}) {
  return IconButton(
      padding: const EdgeInsets.all(5),
      color: ColorManager.blueColor2,
      iconSize: 25,
      onPressed: () {
        BlocProvider.of<ReservationCubit>(context).selectDate(context);
      },
      icon: Icon(icon));
}

Widget addingTimeBtn(
  context, {
  var icon = Icons.date_range,
}) {
  return IconButton(
      padding: const EdgeInsets.all(5),
      color: ColorManager.blueColor2,
      iconSize: 25,
      onPressed: () {
        BlocProvider.of<ReservationCubit>(context).selectTime(context);
      },
      icon: Icon(icon));
}

Widget addingTextFormField(
    TextInputType textInputType, double fieldWidth, fieldController,
    {bool enable = true}) {
  return Container(
    width: fieldWidth,
    color: ColorManager.whiteColor,
    padding: const EdgeInsets.all(1),
    child: TextFormField(
      textAlign: TextAlign.center,
      keyboardType: textInputType,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
      ),
      controller: fieldController,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'required';
      //   }
      //   return null;
      // },
      enabled: enable,
    ),
  );
}

Widget addingCalculatedTextFormField(
    TextInputType textInputType, double fieldWidth, fieldController, context,
    {bool enable = true}) {
  return Container(
    width: fieldWidth,
    color: ColorManager.whiteColor,
    padding: const EdgeInsets.all(1),
    child: TextFormField(
      textAlign: TextAlign.center,
      keyboardType: textInputType,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
      ),
      controller: fieldController,
      onChanged: ((value) =>
          BlocProvider.of<ReservationCubit>(context).setRestValue()),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill field';
        }
        return null;
      },
      enabled: enable,
    ),
  );
}

Widget addingTextAreaField(double fieldWidth, fieldController) {
  return Container(
    width: fieldWidth,
    color: ColorManager.whiteColor,
    padding: const EdgeInsets.all(1),
    child: TextFormField(
      controller: fieldController,
      maxLines: 4,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill field';
        }
        return null;
      },
    ),
  );
}
