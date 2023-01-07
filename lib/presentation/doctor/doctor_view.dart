import 'package:devclinic/core/utils/color_manager.dart';
import 'package:devclinic/presentation/doctor/doctor_cubit.dart';
import 'package:devclinic/presentation/doctor/doctor_states.dart';
import 'package:devclinic/presentation/doctor/doctor_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorCubit>(
      create: (context) {
        return DoctorCubit(IntialDoctorState());
      },
      child: BlocBuilder<DoctorCubit, DoctorStates>(builder: (context, state) {
        var cubitObj = BlocProvider.of<DoctorCubit>(context);
        return Scaffold(
          appBar: doctorAppBar(context),
          backgroundColor: ColorManager.blueColor3,
          body: Container(child: buildDoctorListView(cubitObj.doctorDataList)),
        );
      }),
    );
  }
}
