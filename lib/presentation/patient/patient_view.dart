import 'package:devclinic/core/utils/color_manager.dart';
import 'package:devclinic/presentation/patient/patient_cubit.dart';
import 'package:devclinic/presentation/patient/patient_states.dart';
import 'package:devclinic/presentation/patient/patient_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientCubit>(
      create: (context) {
        return PatientCubit(IntialPatientState());
      },
      child: BlocBuilder<PatientCubit, PatientStates>(
        builder: (context, state) {
          var cubitObj = BlocProvider.of<PatientCubit>(context);

          return Scaffold(
            backgroundColor: ColorManager.blueColor3,
            appBar: patientAppBar(context),
            body: Container(
                child: buildPatientListView(cubitObj.orderedPatientDataList)),
            bottomNavigationBar: buildPatientBottomBar(context),
          );
        },
      ),
    );
  }
}
