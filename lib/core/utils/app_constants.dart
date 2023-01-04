class AppConstants {
  // static const String connectionHost = "sql.freedb.tech";
  // static const int connectionPort = 3306;
  // static const String connectionUser = "freedb_devmoha";
  // static const String connectionPass = "5hE#U2c#%*NPkfy";
  // static const String connectionDbName = "freedb_clinic_db";
  //==============================================================
  static const String connectionHost = "192.168.1.3";
  //static const String connectionHost = "154.179.54.137";
  static const int connectionPort = 3306;
  static const String connectionUser = "root";
  static const String connectionPass = "";
  static const String connectionDbName = "clinic_db";

  static const String getAllReservationQuery =
      "SELECT reservations.*,patients.name FROM `reservations`,patients WHERE reservations.patient_id = patients.patient_id AND reservations.date =";

  static const String getAllPatientQuery =
      "SELECT `patient_id`, `name`, `age`, `address`, `phone`, `education`, `social_statue` FROM `patients`";

  static const String addNewPatientQuery =
      "INSERT INTO `patients`(`name`, `age`, `address`, `phone`, `education`, `social_statue`) VALUES (?,?,?,?,?,?)";

  static const String addNewReservationQuery =
      "INSERT INTO `reservations`(`patient_id`, `type`, `date`, `time`, `price`, `paid`, `rest`, `current_specification`, `given_medicine`, `notes`, `reservation_case`) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
}
