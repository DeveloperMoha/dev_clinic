// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class HomeStates {}

class IntialHomeState extends HomeStates {}

class LoadingHome extends HomeStates {}

class LoadedHome extends HomeStates {}

class ErrorLoadedHome extends HomeStates {}

class ChangeHomeBottomIndex extends HomeStates {
  int bottomIndex;
  ChangeHomeBottomIndex({
    required this.bottomIndex,
  });
  int get setIndex => bottomIndex;
}

class ChangeHomeSelectedDate extends HomeStates {
  String selectedDate;
  ChangeHomeSelectedDate({
    required this.selectedDate,
  });

  String get setDate => selectedDate;
}
