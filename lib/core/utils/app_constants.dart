class AppConstants {
  static const String connectionHost = "sql.freedb.tech";
  static const int connectionPort = 3306;
  static const String connectionUser = "freedb_devmoha";
  static const String connectionPass = "5hE#U2c#%*NPkfy";
  static const String connectionDbName = "freedb_clinic_db";

  static const String getAllReservationQuery =
      "SELECT reservations.*,patients.name FROM `reservations`,patients WHERE reservations.patient_id = patients.patient_id";
}
