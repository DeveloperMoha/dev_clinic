// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class PatientStates {}

class IntialPatientState extends PatientStates {}

class LoadingPatient extends PatientStates {}

class LoadedPatient extends PatientStates {}

class ErrorLoadedPatient extends PatientStates {}

class selectedIndexPatient extends PatientStates {
  int selectedIndex;
  selectedIndexPatient({
    required this.selectedIndex,
  });
}
