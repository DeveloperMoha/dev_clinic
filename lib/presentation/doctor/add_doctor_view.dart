// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devclinic/core/utils/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doctor_cubit.dart';
import 'doctor_states.dart';
import 'doctor_widgets.dart';

class AddDoctorScreen extends StatefulWidget {
  int doctorId = 0;
  String doctorName = "";
  int doctorAge = 0;
  String doctorPhone = "";
  String doctorSpecification = "";

  AddDoctorScreen({super.key});
  AddDoctorScreen.addDoctor({
    super.key,
    id = 0,
    name = "",
    age = 0,
    phone = "",
    specification = "",
  }) {
    doctorId = id;
    doctorName = name;
    doctorAge = age;
    doctorPhone = phone;
    doctorSpecification = specification;
  }
  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  var idController;
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var phoneController = TextEditingController();
  var specificationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> fieldsParameters = ["", "", "", ""];
  @override
  Widget build(BuildContext context) {
    idController = widget.doctorId;

    return BlocProvider<DoctorCubit>(
      create: (context) {
        return DoctorCubit(IntialDoctorState());
      },
      child: BlocBuilder<DoctorCubit, DoctorStates>(builder: (context, state) {
        var cubitObj = BlocProvider.of<DoctorCubit>(context);
        cubitObj.setFields(
            idController,
            nameController,
            ageController,
            phoneController,
            specificationController,
            widget.doctorName,
            widget.doctorAge.toString(),
            widget.doctorPhone,
            widget.doctorSpecification);
        return Scaffold(
          appBar: addDoctorAppBar(context, nameController, ageController,
              phoneController, specificationController, cubitObj),
          backgroundColor: ColorManager.blueColor3,
          body: buildAddDoctorBody(
              idController,
              nameController,
              ageController,
              phoneController,
              specificationController,
              context,
              widget.doctorId,
              formKey,
              cubitObj),
        );
      }),
    );
  }
}
